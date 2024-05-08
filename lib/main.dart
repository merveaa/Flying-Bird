import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Eklediğimiz kütüphane
import 'package:flyingbird/game/flyingbird_game.dart';
import 'package:flyingbird/screens/game_over.dart';
import 'package:flyingbird/screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final game = FlappyBirdGame();

  // Status bar rengini transparent yapmak için
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Debug yazısını kaldırmak için
    home: GameWidget(
      game: game,
      initialActiveOverlays: const ['mainMenu'],
      overlayBuilderMap: {
        'gameOver': (context, _) => GameOverScreen(
              game: game,
              finalScore: game.score,
              bestScore: game.bestScore,
            ),
        'mainMenu': (context, _) => MainMenuScreen(game: game),
      },
    ),
  ));
}
