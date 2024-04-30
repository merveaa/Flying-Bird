import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ScoreComponent extends PositionComponent {
  int score; // `final` anahtar kelimesini kaldırdık.
  late TextPainter tp;

  ScoreComponent({required this.score}) {
    tp = TextPainter(
      text: TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
        ),
        text: '$score',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    tp.layout();
    position = Vector2((gameSize.x - tp.width) / 2, gameSize.y / 4);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    tp.paint(canvas, Offset.zero);
  }

  void updateScore(int newScore) {
    score = newScore;
    tp.text = TextSpan(
      text: '$score',
      style: TextStyle(
        color: Colors.white,
        fontSize: 40,
      ),
    );
    tp.layout();
  }
}
