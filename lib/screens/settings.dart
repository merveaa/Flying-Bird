import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Gece ve gündüz modunu değiştir
              },
              child: Text('Toggle Day/Night Mode'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Kuş rengini değiştir
              },
              child: Text('Change Bird Color'),
            ),
          ],
        ),
      ),
    );
  }
}
