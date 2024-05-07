import 'dart:math';

import 'package:flame/components.dart';
import 'package:flyingbird/game/config.dart';
import 'package:flyingbird/game/flyingbird_game.dart';
import 'package:flyingbird/components/pipe.dart';
import 'package:flyingbird/game/pipe_position.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();
  final random = Random();

  @override
  onLoad() async {
    position.x = gameRef.size.x;
    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 100 + random.nextDouble() * (heightMinusGround / 4);
    final centerY =
        spacing + random.nextDouble() * (heightMinusGround - spacing);

    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
      Pipe(
          pipePosition: PipePosition.bottom,
          height: heightMinusGround - (centerY + spacing / 2)),
    ]);
  }

  bool passed = false;

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    if (position.x < -10) {
      removeFromParent();
    } else if (!passed &&
        gameRef.bird.position.x > position.x + size.x &&
        !gameRef.isCollided) {
      passed = true;
      gameRef.incrementScore(); // Skor artışını yönetmek için çağrılan metod
    }
  }
}
