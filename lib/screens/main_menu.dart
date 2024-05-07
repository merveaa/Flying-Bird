import 'package:flutter/material.dart';
import 'package:flyingbird/game/flyingbird_game.dart';
import 'package:flyingbird/game/assets.dart';
import 'package:flyingbird/game/config.dart';

class MainMenuScreen extends StatefulWidget {
  final FlappyBirdGame game;
  static const String id = 'mainMenu';

  const MainMenuScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  void initState() {
    super.initState();
    widget.game.pauseEngine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          widget.game.overlays.remove('mainMenu'); // Use widget.game here
          widget.game.resumeEngine(); // Use widget.game here
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.asset(
                AppAssets.mainBackgroundDay,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: Config.groundHeight,
                child: Image.asset(
                  AppAssets.mainGround,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.menu),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
