import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/view/home_screen.dart';
import 'package:tic_tac_toe/view_model/history_view_model.dart';


void main() { // Entry point of the app
  runApp(
    // Provide [HistoryViewModel] to the whole app
    // so that any screen can access win/loss/draw stats.
    ChangeNotifierProvider(
      create: (_) => HistoryViewModel(),
      child: MaterialApp(
        home: HomeScreen(),// Start app at the HomeScreen
      debugShowCheckedModeBanner: false,),  // Removes the "debug" banner
    ),
  );
}
