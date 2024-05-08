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
  late String medalImage;

  @override
  void initState() {
    super.initState();
    finalScoreComponent = ScoreComponent(score: widget.finalScore);
    bestScoreComponent = ScoreComponent(score: widget.bestScore);
    _loadImagesFuture = Future.wait([
      finalScoreComponent.loadImages(),
      bestScoreComponent.loadImages(),
    ]);
    setMedalImage();
  }

  void setMedalImage() {
    if (widget.finalScore > widget.bestScore) {
      medalImage = AppAssets.goldMedal;
    } else if (widget.finalScore == widget.bestScore) {
      medalImage = AppAssets.bronzeMedal;
    } else {
      medalImage = AppAssets.silverMedal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 140),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Transform.scale(
                    scale: 1.5,
                    child: Image.asset(AppAssets.scoreBoard),
                  ),
                  FutureBuilder(
                    future: _loadImagesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Positioned(
                          top: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                child: CustomPaint(
                                  painter: ScorePainter(finalScoreComponent),
                                ),
                              ),
                              SizedBox(height: 50),
                              Container(
                                width: 25,
                                height: 25,
                                child: CustomPaint(
                                  painter: ScorePainter(bestScoreComponent),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  Positioned(
                    top: 17,
                    left: -10,
                    child: Image.asset(
                      medalImage,
                      width: 65,
                      height: 65,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Image.asset(AppAssets.gameover),
              SizedBox(height: 20),
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
              SizedBox(height: 10),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initializeScoreComponent() {
    finalScoreComponent = ScoreComponent(score: widget.finalScore);
    bestScoreComponent = ScoreComponent(score: widget.bestScore);
    _loadImagesFuture = Future.wait([
      finalScoreComponent.loadImages(),
      bestScoreComponent.loadImages(),
    ]);
    setState(() {});
  }
}
