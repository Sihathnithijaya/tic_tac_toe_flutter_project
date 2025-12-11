import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/gradient_backgound.dart';
import 'package:tic_tac_toe/view/home_screen.dart';
import 'package:tic_tac_toe/view/level_screen.dart';
import 'package:tic_tac_toe/view_model/game_view_model.dart';
import 'package:tic_tac_toe/view_model/history_view_model.dart';

class GameScreen extends StatelessWidget {
  final String difficulty;
  final String realPlayer;

  const GameScreen({
    super.key,
    required this.difficulty,
    required this.realPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final humanMark = realPlayer;
    final aiMark = humanMark == 'X' ? 'O' : 'X';
    final history = Provider.of<HistoryViewModel>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => GameViewModel(history: history),
      child: Builder(
        builder: (context) {
          // Trigger AI first move if user is O
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<GameViewModel>(context, listen: false).initGame(
              humanMark: humanMark,
              aiMark: aiMark,
              difficulty: difficulty,
              context: context,
            );
          });

          return Consumer<GameViewModel>(
            builder: (context, gvm, _) {
              if (gvm.gameOverResult != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final result = gvm.gameOverResult!;
                  final message = result == 'Draw'
                      ? "It's a draw!"
                      : "Player $result wins!";

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Game Over'),
                      content: Text(message),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            gvm.reset();
                          },
                          child: const Text('Play Again'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LevelScreen(),
                              ),
                            );
                          },
                          child: const Text("Change Level"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                            );
                          },
                          child: const Text("Main Menu"),
                        ),
                      ],
                    ),
                  );
                });
              }

              return Scaffold(
                appBar: AppBar(
                  leading: const BackButton(color: Colors.white),
                  title: const Text('Tic Tac Toe', style: TextStyle(color: Colors.white)),
                  backgroundColor: const Color.fromARGB(255, 128, 4, 170),
                ),
                backgroundColor: Colors.transparent,
                body: GradientBackground(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Tic Tac Toe', style: TextStyle(fontSize: 32, color: Colors.white)),
                      const SizedBox(height: 20),
                      Text('Selected Level: $difficulty', style: const TextStyle(color: Colors.white70)),
                      const SizedBox(height: 20),
                      Text('Selected Player: $realPlayer', style: const TextStyle(color: Colors.white70)),
                      const SizedBox(height: 20),

                      // Game Board
                      Column(
                        children: List.generate(3, (row) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (col) {
                              final index = row * 3 + col;
                              return GestureDetector(
                                onTap: () {
                                  gvm.humanMove(
                                    index: index,
                                    difficulty: difficulty,
                                    humanMark: humanMark,
                                    aiMark: aiMark,
                                    context: context,
                                  );
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  margin: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 124, 5, 236),
                                    border: Border.all(width: 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      gvm.board[index] ?? '',
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        }),
                      ),

                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: gvm.undo,
                        child: const Text('Undo'),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
