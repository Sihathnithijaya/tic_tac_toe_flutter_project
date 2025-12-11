//lib/view/home_screen
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/view/level_screen.dart';
import 'package:tic_tac_toe/gradient_backgound.dart';
import 'package:tic_tac_toe/view/history_screen.dart';

// The home screen of the Tic Tac Toe app.
// Acts as the entry point and navigation hub.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Navigate to Level Selection screen
  void _goLevelScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            LevelScreen(), // Pushes the player list onto the screen stack
      ),
    );
  }

  // Navigate to History screen
  void _goHistoryScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            HistoryScreen(), // Pushes the player list onto the screen stack
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top AppBar with menu icon
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 128, 4, 170), // Bright red
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 24),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // opens the drawer
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: GradientBackground(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            children: [
              const SizedBox(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Divider line
              SizedBox(
                width: 150,
                height: 1,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),
              // History navigation option
              ListTile(
                leading: const Icon(Icons.history, color: Colors.white),
                title: const Text(
                  'History',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
                onTap: () => _goHistoryScreen(context),
              ),
            ],
          ),
        ),
      ),

      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tic Tac Toe',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 24),

              // Game logo image
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/xoxo.png',
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // "Enter" button -> goes to level selection
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 89, 40, 225),
                      ),
                      onPressed: () => _goLevelScreen(context),
                      child: const Text('Start'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      ///
    );
  }
}
