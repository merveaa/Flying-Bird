import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flyingbird/game/assets.dart';
import 'package:flyingbird/game/flyingbird_game.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Background();
  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(AppAssets.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
