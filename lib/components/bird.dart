import 'dart:async';

import 'package:flame/components.dart';
import 'package:flyingbird/game/assets.dart';
import 'package:flyingbird/game/bird_movement.dart';
import 'package:flyingbird/game/flyingbird_game.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame> {
  Bird();
  @override
  FutureOr<void> onLoad() async {
    final birdMid = await gameRef.loadSprite(AppAssets.bluebirdMidFlap);
    final birdUp = await gameRef.loadSprite(AppAssets.bluebirdUpFlap);
    final birdDown = await gameRef.loadSprite(AppAssets.bluebirdDownFlap);

    gameRef.bluebird;

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = BirdMovement.down;
    sprites = {
      BirdMovement.down: birdDown,
      BirdMovement.up: birdUp,
      BirdMovement.middle: birdMid,
    };
  }
}
