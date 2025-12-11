//lib/model/ai_model
import 'dart:math';

final _rand = Random();

// if X get first


// Returns a random legal move index (0..8) or -1 if none
int easyMove(List<String?> board) {
  final empties = <int>[];
  for (int i = 0; i < board.length; i++) {
    if (board[i] == null) empties.add(i);
  }
  if (empties.isEmpty) return -1;
  return empties[_rand.nextInt(empties.length)];
}

// Medium move: alternates between random and "hard" strategy.
int mediumMove(List<String?> board, int aiTurnCount, String aiMark) {
  if (aiTurnCount % 2 == 0) {
    return easyMove(board);
  } else {
    return hardMove(board, aiMark);
  }
}

// Hard → Pseudocode 1 strategy
int hardMove(List<String?> board, String aiMark) {
  final opp = aiMark == 'X' ? 'O' : 'X';

  // 1. If you or opponent has two in a row, play the third
  for (final line in _winningLines) {
    int a = line[0], b = line[1], c = line[2];
    if (board[a] == aiMark && board[b] == aiMark && board[c] == null) return c;
    if (board[a] == aiMark && board[c] == aiMark && board[b] == null) return b;
    if (board[b] == aiMark && board[c] == aiMark && board[a] == null) return a;

    if (board[a] == opp && board[b] == opp && board[c] == null) return c;
    if (board[a] == opp && board[c] == opp && board[b] == null) return b;
    if (board[b] == opp && board[c] == opp && board[a] == null) return a;
  }

  // 2. If there's a move that creates two lines of two in a row
  for (int i = 0; i < board.length; i++) {
    if (board[i] == null) {
      board[i] = aiMark;
      int count = 0;
      for (final line in _winningLines) {
        int a = line[0], b = line[1], c = line[2];
        if ((board[a] == aiMark && board[b] == aiMark && board[c] == null) ||
            (board[a] == aiMark && board[c] == aiMark && board[b] == null) ||
            (board[b] == aiMark && board[c] == aiMark && board[a] == null)) {
          count++;
        }
      }
      board[i] = null;
      if (count >= 2) return i;
    }
  }

  // 3. If center is free → play center
  if (board[4] == null) return 4;

  // 4. If opponent has corner, play opposite corner
  if (board[0] == opp && board[8] == null) return 8;
  if (board[8] == opp && board[0] == null) return 0;
  if (board[2] == opp && board[6] == null) return 6;
  if (board[6] == opp && board[2] == null) return 2;

  // 5. If any free corner → play it
  final corners = [0, 2, 6, 8];
  for (int c in corners) {
    if (board[c] == null) return c;
  }

  // 6. Otherwise → play any empty
  return easyMove(board);
}

// Winning lines for 3x3 tic-tac-toe
const List<List<int>> _winningLines = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
  [0, 3, 6], [1, 4, 7], [2, 5, 8], // cols
  [0, 4, 8], [2, 4, 6], // diagonals
];
