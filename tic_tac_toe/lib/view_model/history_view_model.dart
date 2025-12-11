//lib/view_model/history_view_model
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ViewModel that handles storing and retrieving game history.
/// It tracks how many times the user (as X or O) has won,
/// how many times the AI (as X or O) has won,
/// and how many games ended in a draw.
class HistoryViewModel extends ChangeNotifier {
  // Number of wins by the user playing as X

  int winUserX = 0;
  // Number of wins by the user playing as O

  int winUserO = 0;
  // Number of wins by the AI playing as X

  int winAiX = 0;
  // Number of wins by the AI playing as O

  int winAiO = 0;
  // Number of games that ended in a draw

  int draws = 0;
  // Constructor automatically loads saved stats when this ViewModel is created.

  HistoryViewModel() {
    _loadHistory();
  }
  // Loads history data from SharedPreferences (persistent storage).
  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    winUserX = prefs.getInt("winUserX") ?? 0;
    winUserO = prefs.getInt("winUserO") ?? 0;
    winAiX = prefs.getInt("winAiX") ?? 0;
    winAiO = prefs.getInt("winAiO") ?? 0;
    draws = prefs.getInt('draws') ?? 0;

    notifyListeners(); // update UI when data is loaded
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('winUserX', winUserX);
    prefs.setInt('winUserO', winUserO);
    prefs.setInt('winAiX', winAiX);
    prefs.setInt('winAiO', winAiO);
    prefs.setInt('draws', draws);
  }

  // Records a game result.
  //
  // - [winner] is "X", "O", or "draw".
  // - [userPlayer] is the mark the human chose ("X" or "O").
  //
  // Updates the correct counter depending on the outcome.

  void recordHistory({required String winner, required String userPlayer}) {
    if (winner == "draw") {
      draws++;
    } else if (winner == userPlayer) {
      if (userPlayer == "X") {
        winUserX++;
      } else {
        winUserO++;
      }
    } else {
      if (winner == "X") {
        winAiX++;
      } else {
        winAiO++;
      }
    }
    _saveHistory(); // persist the updated stats
    notifyListeners(); // refresh UI listeners
  }

  // Resets all stats back to zero.
  Future<void> resetStats() async {
    winUserX = winUserO = winAiX = winAiO = draws = 0;
    await _saveHistory();
    notifyListeners(); // refresh UI after reset
  }
}
