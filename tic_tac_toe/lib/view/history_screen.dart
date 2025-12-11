//lib/view/history_screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/gradient_backgound.dart';
import 'package:tic_tac_toe/view_model/history_view_model.dart';

// Screen that shows the player's game history and statistics.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryViewModel>(
      builder: (context, stats, child) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(color: Colors.white),
            title: const Text('History', style: TextStyle(color: Colors.white)),
            backgroundColor: Color.fromARGB(255, 128, 4, 170), // Bright red
          ),
          backgroundColor: Color.fromARGB(255, 30, 30, 60),
          body: GradientBackground(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Game History',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // --- Player Stats ---
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: ListTile(
                      leading: Icon(Icons.man, size: 32, color: Colors.black),
                      title: Text('Player:'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User wins as X: ${stats.winUserX}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "User wins as O: ${stats.winUserO}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Draws: ${stats.draws}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // --- AI Stats ---
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: ListTile(
                      leading: Icon(
                        Icons.computer,
                        size: 32,
                        color: Colors.black,
                      ),
                      title: Text('Sytem:'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AI wins as X: ${stats.winAiX}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "AI wins as O: ${stats.winAiO}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Draws: ${stats.draws}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Reset all stored stats
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () => stats.resetStats(),
                    child: const Text("Reset Stats"),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
