import 'package:flutter/material.dart';
import 'package:flyingbird/game/flyingbird_game.dart';
import 'package:flyingbird/game/assets.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game;
  const GameOverScreen({Key? key, required this.game}) : super(key: key);
  @override
  Widget build(BuildContext context) => Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(AppAssets.gameover),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: onRestart,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  'Restart',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ));

  void onRestart() {
    game.bluebird.reset();
    game.overlays.remove('gameOver');

    game.resumeEngine();
  }
}
