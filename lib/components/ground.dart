import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flyingbird/game/assets.dart';
import 'package:flyingbird/game/config.dart';
import 'package:flyingbird/game/flyingbird_game.dart';

class Ground extends ParallaxComponent<FlappyBirdGame> {
  Ground();
  @override
  Future<void> onLoad() async {
    final ground = await Flame.images.load(AppAssets.ground);
    parallax =
        Parallax([ParallaxLayer(ParallaxImage(ground, fill: LayerFill.none))]);
    add(RectangleHitbox(
      position: Vector2(0, game.size.y - Config.groundHeight),
      size: Vector2(game.size.x, Config.groundHeight),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x =
        Config.gameSpeed; //config dosyasında belirlediğim hızı kullandım
  }
}
