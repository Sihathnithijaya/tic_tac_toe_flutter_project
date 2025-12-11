//lib/view/level_screen
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/gradient_backgound.dart';
import 'package:tic_tac_toe/view/game_screen.dart';

// Screen where the user selects the difficulty level (Easy/Medium/Hard)
// and chooses their mark (X or O) before starting the game.
class LevelScreen extends StatefulWidget {
  const LevelScreen({super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  // Stores the chosen difficulty (Easy, Medium, Hard).
  String difficulty = '';
  // Stores the chosen player mark (X or O).
  String realplayer = '';

  // Navigates to the GameScreen if both difficulty and player are selected.
  // Otherwise, shows a warning message.
  void _goToGameScreenState(BuildContext context) {
    if (difficulty.isEmpty || realplayer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('!Please Select level and Player')),
      );
      return;
    }
    // Navigate to GameScreen with the chosen settings
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            GameScreen(difficulty: difficulty, realPlayer: realplayer),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: const Text(
          'Level Select',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 128, 4, 170),
      ),
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tic Tac Toe',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Display selected difficulty & player
            Text(
              difficulty != ''
                  ? 'Select Level: $difficulty '
                  : 'Selected Level: -',
              style: const TextStyle(color: Colors.white70),
            ),

            Text(
              realplayer != ''
                  ? 'Select Player: $realplayer'
                  : 'Selected Player: -',
              style: const TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 20),

            // Difficulty selection'
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Select level:',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      difficulty = 'Easy';
                    });
                  },
                  child: const Text('Easy'),
                ),

                const SizedBox(height: 8, width: 8),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      difficulty = 'Medium';
                    });
                  },
                  child: const Text('Medium'),
                ),

                const SizedBox(height: 8, width: 8),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      difficulty = 'Hard';
                    });
                  },
                  child: const Text('Hard'),
                ),
              ],
            ),

            const SizedBox(height: 24, width: 8),

            // X or O selection Botton
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Select Palyer:',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      realplayer = 'X';
                    });
                  },
                  child: const Text('X'),
                ),
                const SizedBox(width: 8),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      realplayer = 'O';
                    });
                  },
                  child: const Text('O'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Confirm Botton
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 4, 248, 73),
                    ),
                    onPressed: () => _goToGameScreenState(context),
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
