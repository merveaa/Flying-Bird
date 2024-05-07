import 'package:flutter/material.dart';
import 'package:flyingbird/components/score.dart';
import 'package:flyingbird/game/flyingbird_game.dart';
import 'package:flyingbird/game/assets.dart';

class GameOverScreen extends StatefulWidget {
  final FlappyBirdGame game;
  final int finalScore;

  const GameOverScreen({
    Key? key,
    required this.game,
    required this.finalScore,
  }) : super(key: key);

  @override
  _GameOverScreenState createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  late ScoreComponent scoreComponent;
  late Future<void> _loadImagesFuture;

  @override
  void initState() {
    super.initState();
    scoreComponent = ScoreComponent(score: widget.finalScore);
    _loadImagesFuture =
        scoreComponent.loadImages(); // Resimleri yüklemek için Future başlat
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
                          // Resimler yüklendi, şimdi skoru göster
                          return Container(
                            margin: EdgeInsets.only(bottom: 200, left: 180),
                            child: CustomPaint(
                              painter: ScorePainter(scoreComponent),
                            ),
                          );
                        } else {
                          // Yükleniyor, bir yükleme animasyonu veya gösterimi yapabilirsiniz
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
    scoreComponent = ScoreComponent(score: 0); // Skoru sıfırla
    _loadImagesFuture = scoreComponent.loadImages(); // Resimleri yeniden yükle
    setState(() {}); // UI'yi yeniden yükle
  }
}
