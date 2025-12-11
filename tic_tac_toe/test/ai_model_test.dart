import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/model/ai_model.dart';

void main() {
  test('easyMove returns -1 when board is full', () {
    final fullBoard = List<String?>.filled(9, 'X');
    final res = easyMove(fullBoard);
    expect(res, -1);
  });

  test('easyMove returns valid index when board has empties', () {
    final board = List<String?>.filled(9, null);
    board[0] = 'X';
    final res = easyMove(board);
    expect(res, isNot(-1));
    expect(res, inInclusiveRange(0, 8));
    expect(board[res], isNull);
  });

  test('hardMove blocks opponent win', () {
    final board = ['X', 'X', null, null, 'O', null, null, null, null];
    final move = hardMove(board, 'O');
    expect(move, 2); // O should block X from winning
  });

  test('hardMove takes winning move', () {
    final board = ['O', 'O', null, null, 'X', null, null, null, null];
    final move = hardMove(board, 'O');
    expect(move, 2); // O should win
  });

  test('prefers center when no immediate threat', () {
    final board = List<String?>.filled(9, null); // empty board
    final move = hardMove(board, 'X');
    expect(move, 4); // center index
  });

  test('hardMove picks any free corner when center and opposite are taken', () {
  final board = [
    'O', null, null,
    null, 'X', null,
    null, null, null,
  ];
  final move = hardMove(board, 'X');
  expect([2, 6, 8].contains(move), true); // any free corner except 0
});

}
