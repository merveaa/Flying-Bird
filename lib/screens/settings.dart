import 'package:flutter/material.dart';
import 'package:flyingbird/game/flyingbird_game.dart';
import 'package:flyingbird/screens/game_over.dart';

class SettingsScreen extends StatefulWidget {
  final FlappyBirdGame game;
  final String previousScreen;

  const SettingsScreen({
    Key? key,
    required this.game,
    required this.previousScreen,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            // Geri butonuna basıldığında geçerli ekran türüne göre uygun işlevi çağır
            if (widget.previousScreen == 'MainMenu') {
              widget.game.goToMainMenu();
              Navigator.pop(context); // SettingsScreen'e geri dön
            } else if (widget.previousScreen == 'GameOver') {
              Navigator.pop(context); // SettingsScreen'e geri dön
            }
          },
        ),
      ),
    );
  }
}
