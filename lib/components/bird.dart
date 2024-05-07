import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/animation.dart';
import 'package:flyingbird/game/assets.dart';
import 'package:flyingbird/game/bird_movement.dart';
import 'package:flyingbird/game/config.dart';
import 'package:flyingbird/game/flyingbird_game.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Bird();
  @override
  FutureOr<void> onLoad() async {
    final birdMid = await gameRef.loadSprite(AppAssets.bluebirdMidFlap);
    final birdUp = await gameRef.loadSprite(AppAssets.bluebirdUpFlap);
    final birdDown = await gameRef.loadSprite(AppAssets.bluebirdDownFlap);

    gameRef.bird;

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = BirdMovement.down;
    sprites = {
      BirdMovement.down: birdDown,
      BirdMovement.up: birdUp,
      BirdMovement.middle: birdMid,
    };

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.birdVelocity * dt;
  }

  fly() {
    add(
      MoveByEffect(
        Vector2(0, -Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ),
    );
    FlameAudio.play(AppAssets.flying);

    current = BirdMovement.up;
  }

  @override
  onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();
  }

  gameOver() {
    game.isCollided = true;
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
    FlameAudio.play(AppAssets.collision);
  }

  reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
  }
}
