import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flyingbird/game/flyingbird_game.dart';
import 'package:flyingbird/screens/game_over.dart';
import 'package:flyingbird/screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final game = FlappyBirdGame();
  runApp(MaterialApp(
    home: GameWidget(
      game: game,
      initialActiveOverlays: const ['mainMenu'],
      overlayBuilderMap: {
        'gameOver': (context, _) => GameOverScreen(
              game: game,
            ),
        'mainMenu': (context, _) => MainMenuScreen(game: game),
      },
    ),
  ));
}
