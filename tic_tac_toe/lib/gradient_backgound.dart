import 'package:flutter/material.dart';

// A reusable widget that paints a purple gradient background
// and places a child widget on top of it.

// Used in multiple screens (Home, History, Level, etc.)
// so the app keeps a consistent style.

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill entire screen width
      height: double.infinity, // Fill entire screen height
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, // Gradient starts at top-left
          end: Alignment.bottomRight, // and ends at bottom-right
          colors: [
            Color.fromARGB(255, 128, 4, 170),
            Color.fromARGB(255, 124, 5, 236),
          ],
        ),
      ),
      child: child, // Place whatever widget we pass on top
    );
  }
}
