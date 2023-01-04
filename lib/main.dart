import 'package:flutter/material.dart';
import 'package:muvime/screens/loading_screen.dart';

void main() => runApp(const Muvime());

class Muvime extends StatelessWidget {
  const Muvime({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //theme:
      home: LoadingScreen(),
    );
  }
}
