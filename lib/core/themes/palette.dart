import 'package:flutter/material.dart';

import '../../wordle/viewmodels/wordle_viewmodel.dart';

class Palette {
  static const Color transparent = Colors.transparent;
  static const Color green = Colors.green;
  static const Color orange = Colors.orangeAccent;
  static const Color grey = Colors.grey;
  static final Color darkGrey = Colors.grey[700]!;
}

extension KeyboardLetterStateExtension on KeyboardLetterState {
  Color get color {
    switch (this) {
      case KeyboardLetterState.notInWord:
        return Palette.darkGrey;
      case KeyboardLetterState.inWord:
        return Palette.orange;
      case KeyboardLetterState.positionFound:
        return Palette.green;
    }
  }
}
