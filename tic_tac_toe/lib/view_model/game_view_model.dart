import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/model/ai_model.dart';
import 'package:tic_tac_toe/model/game_state.dart';
import 'package:tic_tac_toe/view_model/history_view_model.dart';

/// Full GameViewModel (GVM) for Tic Tac Toe
/// Handles game state, human & AI moves, undo, and history recording
class GameViewModel extends ChangeNotifier {
  GameState _state = GameState.initial();

  /// Reference to history
  final HistoryViewModel history;
  

  void initGame({
    required String humanMark,
    required String aiMark,
    required String difficulty,
    required BuildContext context,
  }) {
    // If human is O, AI is X → AI should move first
    if (humanMark == 'O' && _state.moveLog.isEmpty) {
      _aiMoveTimer = Timer(const Duration(milliseconds: 300), () {
        int aiMove = -1;
        switch (difficulty.toLowerCase()) {
          case 'easy':
            aiMove = easyMove(_state.board);
            break;
          case 'medium':
            aiMove = mediumMove(_state.board, _state.aiTurnCount, aiMark);
            break;
          case 'hard':
            aiMove = hardMove(_state.board, aiMark);
            break;
          default:
            aiMove = easyMove(_state.board);
        }

        if (aiMove != -1 && _state.board[aiMove] == null) {
          final boardAfterAi = List<String?>.from(_state.board);
          boardAfterAi[aiMove] = aiMark;
          final logAfterAi = List<int>.from(_state.moveLog)..add(aiMove);

          _state = _state.copyWith(
            board: boardAfterAi,
            moveLog: logAfterAi,
            aiTurnCount: _state.aiTurnCount + 1,
            xTurn: true, // now it's human's turn
          );
          notifyListeners();
        }
      });
    }
  }

  /// Store pending AI move to cancel if needed
  Timer? _aiMoveTimer;

  /// Winning positions (static)
  final List<List<int>> winningPositions = const [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  GameViewModel({required this.history});

  /// Expose immutable state
  List<String?> get board => List.unmodifiable(_state.board);
  List<int> get moveLog => List.unmodifiable(_state.moveLog);
  int get aiTurnCount => _state.aiTurnCount;
  bool get xTurn => _state.xTurn;
  String? get gameOverResult => _state.gameOverResult;

  get state => null;

  /// Reset game
  void reset() {
    _aiMoveTimer?.cancel();
    _state = GameState.initial();
    notifyListeners();
  }

  /// Undo last AI + human move
  void undo() {
    _aiMoveTimer?.cancel();
    if (_state.moveLog.isEmpty || _state.gameOverResult != null) return;

    final newBoard = List<String?>.from(_state.board);
    final newLog = List<int>.from(_state.moveLog);
    int aiCount = _state.aiTurnCount;

    // Remove last AI move
    if (newLog.isNotEmpty) {
      final lastAi = newLog.removeLast();
      newBoard[lastAi] = null;
      if (aiCount > 0) aiCount--;
    }

    // Remove last human move
    if (newLog.isNotEmpty) {
      final lastHuman = newLog.removeLast();
      newBoard[lastHuman] = null;
    }

    _state = _state.copyWith(
      board: newBoard,
      moveLog: newLog,
      aiTurnCount: aiCount,
      gameOverResult: null,
      xTurn: true,
    );
    notifyListeners();
  }

  /// Human taps a cell (runs human move + delayed AI move)
  void humanMove({
    required int index,
    required String difficulty,
    required String humanMark,
    required String aiMark,
    required BuildContext context,
  }) {
    if (_state.board[index] != null || _state.gameOverResult != null) return;

    // Apply human move
    final newBoard = List<String?>.from(_state.board);
    newBoard[index] = humanMark;
    final newLog = List<int>.from(_state.moveLog)..add(index);

    _state = _state.copyWith(board: newBoard, moveLog: newLog, xTurn: false);
    notifyListeners();

    // Check winner after human move
    final resultAfterHuman = _checkWinner(newBoard);
    if (resultAfterHuman != null) {
      _endGame(resultAfterHuman, humanMark);
      return;
    }

    // Schedule AI move
    _aiMoveTimer = Timer(const Duration(milliseconds: 400), () {
      if (_state.gameOverResult != null) return;

      int aiMove = -1;
      switch (difficulty.toLowerCase()) {
        case 'easy':
          aiMove = easyMove(_state.board);
          break;
        case 'medium':
          aiMove = mediumMove(_state.board, _state.aiTurnCount, aiMark);
          break;
        case 'hard':
          aiMove = hardMove(_state.board, aiMark);
          break;
        default:
          aiMove = easyMove(_state.board);
      }

      if (aiMove != -1 && _state.board[aiMove] == null) {
        final boardAfterAi = List<String?>.from(_state.board);
        boardAfterAi[aiMove] = aiMark;
        final logAfterAi = List<int>.from(_state.moveLog)..add(aiMove);

        _state = _state.copyWith(
          board: boardAfterAi,
          moveLog: logAfterAi,
          aiTurnCount: _state.aiTurnCount + 1,
          xTurn: true,
        );
        notifyListeners();

        final resultAfterAi = _checkWinner(boardAfterAi);
        if (resultAfterAi != null) {
          _endGame(resultAfterAi, humanMark);
        }
      }
    });
  }

  /// Check winner logic
  String? _checkWinner(List<String?> boardSnapshot) {
    for (var pos in winningPositions) {
      final a = pos[0], b = pos[1], c = pos[2];
      final mark = boardSnapshot[a];
      if (mark != null &&
          mark == boardSnapshot[b] &&
          mark == boardSnapshot[c]) {
        return mark; // 'X' or 'O'
      }
    }

    if (boardSnapshot.every((e) => e != null)) {
      return 'Draw';
    }

    return null;
  }

  /// End game and record history
  void _endGame(String result, String userPlayer) {
    _aiMoveTimer?.cancel();
    _state = _state.copyWith(gameOverResult: result);
    notifyListeners();

    if (result == 'Draw') {
      history.recordHistory(winner: 'draw', userPlayer: userPlayer);
    } else {
      history.recordHistory(winner: result, userPlayer: userPlayer);
    }
  }

String? checkWinnerForTest(List<String?> boardSnapshot) => _checkWinner(boardSnapshot);
}
