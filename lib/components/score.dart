import 'dart:async';
import 'dart:ui' as ui;
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flyingbird/game/assets.dart';

class ScoreComponent extends PositionComponent {
  int score;
  late List<ui.Image> numberImages; // Doğrudan nullable tanımlayın

  ScoreComponent({required this.score}) {
    numberImages = []; // Boş bir liste ile başlatıldı
    loadImages(); // Bu metod resimleri yükleyecek
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

  void reset(int newScore) {
    score = newScore;
    numberImages = [];
    loadImages();
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = Vector2((gameSize.x - 100) / 2, 50);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Eğer resimler yüklenmişse skoru çiz
    if (numberImages.isNotEmpty) {
      drawScore(canvas);
    }
  }

  void drawScore(Canvas canvas) {
    final String scoreString = score.toString();
    const double imageWidth = 30;
    const double spacing = 3;

    double offsetX = position.x;
    for (int i = 0; i < scoreString.length; i++) {
      final int digit = int.parse(scoreString[i]);
      final ui.Image? digitImage = numberImages?[digit];
      if (digitImage != null) {
        canvas.drawImage(digitImage, Offset(offsetX, position.y), Paint());
      }
      offsetX += imageWidth + spacing;
    }
  }

  void updateScore(int newScore, {bool playSound = false}) {
    score = newScore;
    if (playSound) {
      FlameAudio.play(AppAssets.point);
    }
  }
}

class ScorePainter extends CustomPainter {
  final ScoreComponent scoreComponent;

  ScorePainter(this.scoreComponent);

  @override
  void paint(Canvas canvas, Size size) {
    scoreComponent.render(canvas);
  }

  @override
  bool shouldRepaint(covariant ScorePainter oldDelegate) {
    return oldDelegate.scoreComponent != scoreComponent;
  }
}
