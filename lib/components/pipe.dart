import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flyingbird/game/assets.dart';
import 'package:flyingbird/game/config.dart';
import 'package:flyingbird/game/flyingbird_game.dart';
import 'package:flyingbird/game/pipe_position.dart';

class Pipe extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Pipe({required this.height, required this.pipePosition});

  @override
  final double height;
  final PipePosition pipePosition;
  @override
  onLoad() async {
    final pipegreen = await Flame.images.load(AppAssets.pipeGreen);

    final pipegreenrotated =
        await Flame.images.load(AppAssets.pipeGreenRotated);
    size = Vector2(50, height);

    switch (pipePosition) {
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(pipegreenrotated);
        break;
      case PipePosition.bottom:
        position.y = gameRef.size.y - size.y - Config.groundHeight;
        sprite = Sprite(pipegreen);
        break;
    }

    add(RectangleHitbox());
  }
}
