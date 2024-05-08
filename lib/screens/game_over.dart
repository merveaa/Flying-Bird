import 'package:flutter/material.dart';
import 'package:flyingbird/components/score.dart';
import 'package:flyingbird/game/flyingbird_game.dart';
import 'package:flyingbird/game/assets.dart';

class GameOverScreen extends StatefulWidget {
  final FlappyBirdGame game;
  final int finalScore;
  final int bestScore;

  const GameOverScreen({
    Key? key,
    required this.game,
    required this.finalScore,
    required this.bestScore,
  }) : super(key: key);

  @override
  _GameOverScreenState createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  late ScoreComponent finalScoreComponent;
  late ScoreComponent bestScoreComponent;
  late Future<void> _loadImagesFuture;

  @override
  void initState() {
    super.initState();
    finalScoreComponent = ScoreComponent(score: widget.finalScore);
    bestScoreComponent = ScoreComponent(score: widget.bestScore);
    _loadImagesFuture = Future.wait([
      finalScoreComponent.loadImages(),
      bestScoreComponent.loadImages(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 130),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.scale(
                      scale: 1.4,
                      child: Image.asset(AppAssets.scoreBoard),
                    ),
                    FutureBuilder(
                      future: _loadImagesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 60, left: 180),
                                child: CustomPaint(
                                  painter: ScorePainter(finalScoreComponent),
                                ),
                              ),
                              //SizedBox(height: 80),
                              Container(
                                margin: EdgeInsets.only(bottom: 140, left: 180),
                                child: CustomPaint(
                                  painter: ScorePainter(bestScoreComponent),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
                Image.asset(AppAssets.gameover),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    widget.game.restartGame();
                    initializeScoreComponent();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    'Restart',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.game.goToMainMenu();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    'Menu',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void initializeScoreComponent() {
    finalScoreComponent = ScoreComponent(
        score: widget.finalScore); // Final skor için bileşeni yeniden başlat
    bestScoreComponent = ScoreComponent(
        score: widget.bestScore); // En iyi skor için bileşeni yeniden başlat
    _loadImagesFuture = Future.wait([
      finalScoreComponent.loadImages(),
      bestScoreComponent.loadImages(),
    ]); // Her iki bileşenin resimlerini yeniden yükleyin
    setState(() {}); // UI'yi yeniden yükle
  }
}
