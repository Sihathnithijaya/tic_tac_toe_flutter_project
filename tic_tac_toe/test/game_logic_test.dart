import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/view_model/game_view_model.dart';
import 'package:tic_tac_toe/view_model/history_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });


  testWidgets('Player X wins by first row', (WidgetTester tester) async {
    final history = HistoryViewModel();
    final gvm = GameViewModel(history: history);

    gvm.humanMove(index: 0, difficulty: 'easy', humanMark: 'X', aiMark: 'O', context: tester.element(find.byType(Container)));
    await tester.pump(const Duration(milliseconds: 500)); // Wait for AI move

    gvm.humanMove(index: 1, difficulty: 'easy', humanMark: 'X', aiMark: 'O', context: tester.element(find.byType(Container)));
    await tester.pump(const Duration(milliseconds: 500));

    gvm.humanMove(index: 2, difficulty: 'easy', humanMark: 'X', aiMark: 'O', context: tester.element(find.byType(Container)));
    await tester.pump(const Duration(milliseconds: 500));

    expect(gvm.gameOverResult, 'X');
  });

  testWidgets('Detect draw when board fills without winner', (WidgetTester tester) async {
    final history = HistoryViewModel();
    final gvm = GameViewModel(history: history);

    final moves = [0, 1, 2, 4, 3, 5, 7, 6, 8];
    for (var idx in moves) {
      gvm.humanMove(index: idx, difficulty: 'easy', humanMark: 'X', aiMark: 'O', context: tester.element(find.byType(Container)));
      await tester.pump(const Duration(milliseconds: 500));
    }

    expect(gvm.gameOverResult, 'Draw');
  });

}
