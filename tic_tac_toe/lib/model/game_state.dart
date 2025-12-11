// lib/View_model/game_state.dart

// Represents the current state of a Tic Tac Toe game.

class GameState {
  // The 3x3 game board represented as a 1D list.
  // Each cell can be:
  // - 'X' if player X has marked it
  // - 'O' if player O has marked it
  // - null if the cell is empty

  final List<String?> board;
  // Keeps track of all moves made by storing the indices of the cells played.
  // Useful for undo functionality or replaying the game.
  final List<int> moveLog;

  // Counts how many turns the AI has taken so far.
  // Helpful for AI difficulty scaling or analytics.
  final int aiTurnCount;

  // Indicates whose turn it is:
  // - true  -> X's turn
  // - false -> O's turn
  final bool xTurn;

  // Stores the game outcome if the game is over:
  // - 'X' if X wins
  // - 'O' if O wins
  // - 'Draw' if the game ends in a tie
  // - null if the game is still ongoing
  final String? gameOverResult; // 'X' | 'O' | 'Draw' | null

  // Standard constructor for creating a new game state.
  GameState({
    required this.board,
    required this.moveLog,
    required this.aiTurnCount,
    required this.xTurn,
    this.gameOverResult,
  });

  // Factory constructor to create a brand-new initial game state.
  // All board cells are empty, move log is empty, it's X's turn, and no game result yet.
  factory GameState.initial() => GameState(
    board: List<String?>.filled(9, null),
    moveLog: [],
    aiTurnCount: 0,
    xTurn: true,
    gameOverResult: null,
  );

  // Creates a new GameState by copying the current one and updating only the provided fields.
  // Useful for immutability when updating state in state management.
  GameState copyWith({
    List<String?>? board,
    List<int>? moveLog,
    int? aiTurnCount,
    bool? xTurn,
    String? gameOverResult,
  }) {
    return GameState(
      board: board ?? List<String?>.from(this.board),
      moveLog: moveLog ?? List<int>.from(this.moveLog),
      aiTurnCount: aiTurnCount ?? this.aiTurnCount,
      xTurn: xTurn ?? this.xTurn,
      gameOverResult: gameOverResult,
    );
  }
}
