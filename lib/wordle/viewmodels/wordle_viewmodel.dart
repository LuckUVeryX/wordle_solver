import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../../core/logs/app_logger.dart';
import '../../core/repositories/word_repository.dart';
import '../../core/services/app_preference.dart';
import '../view/widgets/widgets.dart';

enum GameState { win, lose, error, normal }

enum KeyboardLetterState { notInWord, inWord, positionFound }

class WordleViewmodel extends ChangeNotifier {
  WordleViewmodel(this._repository, this._preferences) {
    _log = getLogger(runtimeType.toString());
    startNewGame();
  }

  late final Logger _log;
  final WordRepository _repository;
  final AppPreferences _preferences;

  String get secretWord => _secretWord;
  late String _secretWord;

  static const _maxWordLength = 5;
  static const _maxAttempts = 6;

  GameState get gameState => _state;
  late GameState _state;

  int get currGuessIdx => _currGuessIdx;
  late int _currGuessIdx;

  List<String> get wordGuesses => List.unmodifiable(_wordGuesses);
  late List<String> _wordGuesses;

  Map<String, KeyboardLetterState> get coloredLetters =>
      Map.unmodifiable(_coloredLetters);
  final Map<String, KeyboardLetterState> _coloredLetters = {};

  void submitWord() async {
    if (_isGameFinish) return;

    if (_wordGuesses[_currGuessIdx].length != _maxWordLength) {
      _state = GameState.error;
      notifyListeners();
      return;
    }

    if (_wordGuesses[_currGuessIdx] == _secretWord) {
      _state = GameState.win;
      _updateColoredLetters();
      _currGuessIdx++;
      notifyListeners();

      final stats = _preferences.statistics;
      await _preferences.saveStatistics(
        stats.copyWith(
          currStreak: stats.currStreak + 1,
          gamesPlayed: stats.gamesPlayed + 1,
          gamesWon: stats.gamesWon + 1,
          maxStreak: max(stats.currStreak + 1, stats.maxStreak),
          guessDistribution: Map.fromEntries(
            (stats.guessDistribution
                  ..update(_currGuessIdx.toString(), (value) => value + 1,
                      ifAbsent: () => 1))
                .entries,
          ),
        ),
      );
      return;
    }

    if (!_repository.wordExists(_wordGuesses[_currGuessIdx])) {
      _state = GameState.error;
      notifyListeners();
      return;
    }

    _state = GameState.normal;
    _updateColoredLetters();
    _currGuessIdx++;
    notifyListeners();

    if (currGuessIdx >= _maxAttempts) {
      _state = GameState.lose;
      notifyListeners();

      final stats = _preferences.statistics;
      await _preferences.saveStatistics(
        stats.copyWith(
          currStreak: 0,
          gamesPlayed: stats.gamesPlayed + 1,
          maxStreak: max(stats.currStreak, stats.maxStreak),
          guessDistribution: Map.fromEntries(
            (stats.guessDistribution
                  ..update('-1', (value) => value + 1, ifAbsent: () => 1))
                .entries,
          ),
        ),
      );
      return;
    }
    return;
  }

  void setLetter(KeyboardLetter key) {
    if (_isGameFinish) return;

    _state = GameState.normal;
    if (_wordGuesses[_currGuessIdx].length < _maxWordLength) {
      _wordGuesses[_currGuessIdx] += key.name;
      notifyListeners();
    }
  }

  void removeLetter() {
    if (_isGameFinish) return;

    _state = GameState.normal;
    if (_wordGuesses[_currGuessIdx].isNotEmpty) {
      _wordGuesses[_currGuessIdx] = _wordGuesses[_currGuessIdx]
          .substring(0, _wordGuesses[_currGuessIdx].length - 1);
      notifyListeners();
    }
  }

  void startNewGame() {
    _state = GameState.normal;
    _currGuessIdx = 0;
    _wordGuesses = List.filled(6, '');
    _secretWord = _repository.getNextWord();
    _coloredLetters.clear();
    _log.i('Secret Word: $_secretWord');
    notifyListeners();
  }

  bool get _isGameFinish => _state == GameState.lose || _state == GameState.win;

  void _updateColoredLetters() {
    final wordMap = _wordGuesses[currGuessIdx].split('').asMap();

    wordMap.forEach((idx, char) {
      if (_coloredLetters[char] == KeyboardLetterState.positionFound) {
        return;
      }

      if (_secretWord.contains(char)) {
        _coloredLetters[char] = KeyboardLetterState.inWord;
      } else {
        _coloredLetters[char] = KeyboardLetterState.notInWord;
      }

      if (_secretWord[idx] == char) {
        _coloredLetters[char] = KeyboardLetterState.positionFound;
      }
    });
  }
}
