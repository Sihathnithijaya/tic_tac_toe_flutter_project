import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/view_model/game_view_model.dart';
import 'package:tic_tac_toe/view_model/history_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Required for SharedPreferences and timers

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('humanMove updates board and moveLog; undo removes human and AI move', (WidgetTester tester) async {
    final history = HistoryViewModel();
    final gvm = GameViewModel(history: history);

    expect(gvm.board.every((e) => e == null), true);
    expect(gvm.moveLog.length, 0);

    // Simulate human move
    gvm.humanMove(
      index: 4,
      difficulty: 'easy',
      humanMark: 'X',
      aiMark: 'O',
      context: tester.element(find.byType(Container)), // Dummy context
    );

    // Wait for AI move to complete
    await tester.pump(const Duration(milliseconds: 500));

    // After both moves
    expect(gvm.board[4], 'X');
    expect(gvm.moveLog.length, 2); // Human + AI

    // Undo should remove both moves
    gvm.undo();
    expect(gvm.board[4], isNull);
    expect(gvm.moveLog.length, 0);
  });
}
