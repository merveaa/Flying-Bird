import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ScoreComponent extends PositionComponent {
  int score;
  late List<ui.Image> numberImages;

  ScoreComponent({required this.score}) {
    loadImages(); // Call the function to load images asynchronously
  }

  Future<void> loadImages() async {
    numberImages = await Future.wait(List.generate(10, (index) async {
      final imageName = 'assets/images/$index.png';
      final ByteData data = await rootBundle.load(imageName);
      final Uint8List bytes = Uint8List.fromList(data.buffer.asUint8List());
      final Completer<ui.Image> completer = Completer();
      ui.decodeImageFromList(bytes, (ui.Image img) {
        completer.complete(img);
      });
      return completer.future;
    }));
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    // Define the position of the score component
    position = Vector2((gameSize.x - 100) / 2, 50); // Adjust position as needed
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    drawScore(canvas);
  }

  void drawScore(Canvas canvas) {
    if (numberImages == null) return; // Check if images are loaded
    final String scoreString = score.toString();
    final double imageWidth = 30;
    final double spacing = 3;

    double offsetX = position.x;
    for (int i = 0; i < scoreString.length; i++) {
      final int digit = int.parse(scoreString[i]);
      final ui.Image digitImage = numberImages[digit];
      canvas.drawImage(digitImage, Offset(offsetX, position.y), Paint());
      offsetX += imageWidth + spacing;
    }
  }

  void updateScore(int newScore) {
    score = newScore;
  }
}
