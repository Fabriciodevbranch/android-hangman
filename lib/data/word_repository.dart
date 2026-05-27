import 'dart:math';

import '../core/models/category.dart';
import 'local_words.dart';

class WordRepository {
  WordRepository({Random? random}) : _random = random ?? Random();

  final Random _random;

  String randomWordFor(Category category) {
    final words = category == Category.random
        ? LocalWords.wordsForRandomCategory
        : (LocalWords.byCategory[category.id] ?? const <String>[]);

    if (words.isEmpty) {
      throw StateError('No local words available for ${category.id}.');
    }

    return words[_random.nextInt(words.length)];
  }
}
