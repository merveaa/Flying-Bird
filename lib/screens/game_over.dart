import 'package:flutter/material.dart';
import 'package:flyingbird/game/flyingbird_game.dart';
import 'package:flyingbird/game/assets.dart';
import 'package:flyingbird/screens/settings.dart';

class GameOverScreen extends StatefulWidget {
  final FlappyBirdGame game;

  const GameOverScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  _GameOverScreenState createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Stack(
        children: [
          Center(
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
                  onPressed: () {
                    widget.game.restartGame();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text(
                    'Restart',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.game.goToMainMenu();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text(
                    'Menu',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 23,
            right: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                      previousScreen: 'GameOver', game: widget.game),
                ));
              },
              child: const Icon(Icons.settings, size: 55),
            ),
          ),
        ],
      ),
    );
  }
}
