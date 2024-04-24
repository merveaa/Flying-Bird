import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flyingbird/game/flyingbird_game.dart';

void main() {
  final game = FlappyBirdGame();
  runApp(GameWidget(game: game));
}
