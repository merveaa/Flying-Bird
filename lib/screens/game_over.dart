import 'package:flutter/material.dart';
import 'package:flyingbird/game/flyingbird_game.dart';
import 'package:flyingbird/game/assets.dart';

class GameOverScreen extends StatelessWidget {
  final Function onRestart; // Function parameter to handle restart
  final Function onMenu; // Function parameter to handle going to the main menu
  const GameOverScreen(
      {Key? key, required this.onRestart, required this.onMenu})
      : super(key: key);

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
                onPressed: () {
                  onRestart();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  'Restart',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  onMenu(); // Call the onMenu function
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  'Menu',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      );
}
