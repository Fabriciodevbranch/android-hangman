import 'package:flutter/foundation.dart';

import '../core/enums/game_status.dart';
import '../core/models/category.dart';
import '../core/models/game_session.dart';
import '../core/utils/accent_normalizer.dart';
import '../data/word_repository.dart';

class GameController extends ChangeNotifier {
  GameController({WordRepository? wordRepository})
      : _wordRepository = wordRepository ?? WordRepository();

  final WordRepository _wordRepository;

  Category _selectedCategory = Category.random;
  bool _soundEnabled = true;
  bool _nightModeEnabled = false;
  GameSession? _session;

  Category get selectedCategory => _selectedCategory;
  bool get isSoundEnabled => _soundEnabled;
  bool get isNightModeEnabled => _nightModeEnabled;
  GameSession? get session => _session;

  List<String> get visibleCharacters {
    final currentSession = _session;
    if (currentSession == null) {
      return const <String>[];
    }

    return currentSession.originalWord.split('').map((character) {
      if (!AccentNormalizer.isGuessableLetter(character)) {
        return character;
      }

      final normalized = AccentNormalizer.normalize(character);
      return currentSession.guessedLetters.contains(normalized)
          ? character
          : '_';
    }).toList(growable: false);
  }

  List<String> get guessedLettersSorted {
    final currentSession = _session;
    if (currentSession == null) {
      return const <String>[];
    }

    final guessedLetters = currentSession.guessedLetters.toList()..sort();
    return guessedLetters;
  }

  List<String> get wrongLettersSorted {
    final currentSession = _session;
    if (currentSession == null) {
      return const <String>[];
    }

    final wrongLetters = currentSession.wrongLetters.toList()..sort();
    return wrongLetters;
  }

  void selectCategory(Category category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void updateSoundEnabled(bool value) {
    _soundEnabled = value;
    // Future sound effects can read this toggle before playing pencil taps.
    notifyListeners();
  }

  void updateNightMode(bool value) {
    _nightModeEnabled = value;
    // Future premium themes can branch from this setting or swap theme packs.
    notifyListeners();
  }

  void startGame([Category? category]) {
    final nextCategory = category ?? _selectedCategory;
    _selectedCategory = nextCategory;

    final word = _wordRepository.randomWordFor(nextCategory);

    _session = GameSession.initial(
      originalWord: word.toUpperCase(),
      normalizedWord: AccentNormalizer.normalize(word),
      category: nextCategory,
    );
    notifyListeners();
  }

  void guessLetter(String letter) {
    final currentSession = _session;
    if (currentSession == null || currentSession.status != GameStatus.playing) {
      return;
    }

    final normalizedLetter = AccentNormalizer.normalize(letter);
    if (!RegExp(r'^[A-Z]$').hasMatch(normalizedLetter) ||
        currentSession.guessedLetters.contains(normalizedLetter)) {
      return;
    }

    final guessedLetters = <String>{
      ...currentSession.guessedLetters,
      normalizedLetter,
    };
    final wasCorrect = currentSession.normalizedWord.contains(normalizedLetter);
    final wrongLetters = wasCorrect
        ? currentSession.wrongLetters
        : <String>{...currentSession.wrongLetters, normalizedLetter};
    final remainingAttempts = wasCorrect
        ? currentSession.remainingAttempts
        : currentSession.remainingAttempts - 1;

    final nextStatus = _didRevealEveryLetter(
      originalWord: currentSession.originalWord,
      guessedLetters: guessedLetters,
    )
        ? GameStatus.won
        : remainingAttempts <= 0
            ? GameStatus.lost
            : GameStatus.playing;

    _session = currentSession.copyWith(
      guessedLetters: guessedLetters,
      wrongLetters: wrongLetters,
      remainingAttempts: remainingAttempts,
      status: nextStatus,
    );
    notifyListeners();
  }

  void resetSession() {
    _session = null;
    notifyListeners();
  }

  bool isLetterDisabled(String letter) {
    final currentSession = _session;
    if (currentSession == null) {
      return false;
    }

    return currentSession.guessedLetters.contains(
      AccentNormalizer.normalize(letter),
    );
  }

  bool _didRevealEveryLetter({
    required String originalWord,
    required Set<String> guessedLetters,
  }) {
    for (final character in originalWord.split('')) {
      if (!AccentNormalizer.isGuessableLetter(character)) {
        continue;
      }

      if (!guessedLetters.contains(AccentNormalizer.normalize(character))) {
        return false;
      }
    }

    return true;
  }
}
