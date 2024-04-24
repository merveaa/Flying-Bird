import 'package:flame/game.dart';
import 'package:flyingbird/components/background.dart';
import 'package:flyingbird/components/bird.dart';
import 'package:flyingbird/components/ground.dart';

class FlappyBirdGame extends FlameGame {
  FlappyBirdGame();
  late Bird bluebird;
  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bluebird = Bird(),
    ]);
  }
}
