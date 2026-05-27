import '../enums/game_status.dart';
import 'category.dart';

class GameSession {
  final String originalWord;
  final String normalizedWord;
  final Category category;
  final Set<String> guessedLetters;
  final Set<String> wrongLetters;
  final int maxAttempts;
  final int remainingAttempts;
  final GameStatus status;

  GameSession({
    required this.originalWord,
    required this.normalizedWord,
    required this.category,
    required Set<String> guessedLetters,
    required Set<String> wrongLetters,
    required this.maxAttempts,
    required this.remainingAttempts,
    required this.status,
  })  : guessedLetters = Set.unmodifiable(guessedLetters),
        wrongLetters = Set.unmodifiable(wrongLetters);

  factory GameSession.initial({
    required String originalWord,
    required String normalizedWord,
    required Category category,
    int maxAttempts = 6,
  }) {
    return GameSession(
      originalWord: originalWord,
      normalizedWord: normalizedWord,
      category: category,
      guessedLetters: <String>{},
      wrongLetters: <String>{},
      maxAttempts: maxAttempts,
      remainingAttempts: maxAttempts,
      status: GameStatus.playing,
    );
  }

  int get wrongAttempts => maxAttempts - remainingAttempts;

  GameSession copyWith({
    String? originalWord,
    String? normalizedWord,
    Category? category,
    Set<String>? guessedLetters,
    Set<String>? wrongLetters,
    int? maxAttempts,
    int? remainingAttempts,
    GameStatus? status,
  }) {
    return GameSession(
      originalWord: originalWord ?? this.originalWord,
      normalizedWord: normalizedWord ?? this.normalizedWord,
      category: category ?? this.category,
      guessedLetters: guessedLetters ?? this.guessedLetters,
      wrongLetters: wrongLetters ?? this.wrongLetters,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      remainingAttempts: remainingAttempts ?? this.remainingAttempts,
      status: status ?? this.status,
    );
  }
}
