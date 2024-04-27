import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flyingbird/game/flyingbird_game.dart';
import 'package:flyingbird/screens/game_over.dart';
import 'package:flyingbird/screens/main_menu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final game = FlappyBirdGame();
  runApp(GameWidget(
    game: game,
    initialActiveOverlays: const ['mainMenu'],
    overlayBuilderMap: {
      'gameOver': (context, _) => GameOverScreen(
            onRestart: () {
              // Restart logic goes here
              game.restartGame(); // Call restart method from FlappyBirdGame
            },
          ),
      'mainMenu': (context, _) => MainMenuScreen(game: game),
    },
  ));
}
