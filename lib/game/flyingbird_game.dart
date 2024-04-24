import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/timer.dart';
import 'package:flyingbird/components/background.dart';
import 'package:flyingbird/components/bird.dart';
import 'package:flyingbird/components/ground.dart';
import 'package:flyingbird/components/pipe_group.dart';
import 'package:flyingbird/game/config.dart';

class FlappyBirdGame extends FlameGame with TapDetector {
  FlappyBirdGame();
  late Bird bluebird;
  Timer interval = Timer(Config.pipesInterval, repeat: true);
  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bluebird = Bird(),
    ]);

    interval.onTick = () => add(PipeGroup());
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
  }

  @override
  void onTap() {
    super.onTap();
    bluebird.fly();
  }
}
