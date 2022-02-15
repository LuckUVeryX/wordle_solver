import 'dart:math';

class WordRepository {
  WordRepository(this._words)
      : _random = Random(DateTime.now().year * 1000 +
            DateTime.now().month * 100 +
            DateTime.now().day);

  final List<String> _words;

  final Random _random;

  /// Generates next random word.
  String getNextWord() {
    return _words[_random.nextInt(_words.length)];
  }

  /// Returns a [bool] indicating if the word exists or not.
  bool wordExists(String word) {
    return _words.contains(word);
  }
}
