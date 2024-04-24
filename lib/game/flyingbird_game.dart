import 'package:flame/game.dart';
import 'package:flyingbird/components/background.dart';

class FlappyBirdGame extends FlameGame {
  FlappyBirdGame();
  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
    ]);
  }
}
