import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/themes/themes.dart';
import '../../viewmodels/wordle_viewmodel.dart';

class WordleGrid extends StatelessWidget {
  const WordleGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GridView.count(
      crossAxisCount: 5,
      crossAxisSpacing: 4.0,
      mainAxisSpacing: 4.0,
      children: List.generate(6 * 5, (index) {
        return Consumer<WordleViewmodel>(builder: (_, value, __) {
          final letters = value.wordGuesses.join();
          final letter = letters.length > index ? letters[index] : '';

          Color? color = _getGridColor(letter, value, index);
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Palette.grey),
              color: color,
            ),
            child: Center(
              child: Text(letter.toUpperCase(), style: textTheme.headline3),
            ),
          );
        });
      }),
    );
  }

  Color? _getGridColor(String letter, WordleViewmodel value, int index) {
    Color? color;
    if (letter.isNotEmpty &&
        value.currGuessIdx > 0 &&
        index < 5 * value.currGuessIdx) {
      final indexInRow = index % 5;
      if (value.wordGuesses.join().contains(letter)) {
        color = Palette.darkGrey;
      }
      if (value.secretWord.contains(letter)) {
        color = Palette.orange;
      }
      if (value.secretWord[indexInRow] == letter) {
        color = Palette.green;
      }
    }
    return color;
  }
}
