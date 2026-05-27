import 'package:flutter_test/flutter_test.dart';
import 'package:paper_hangman/application/game_controller.dart';
import 'package:paper_hangman/core/enums/game_status.dart';
import 'package:paper_hangman/core/models/category.dart';
import 'package:paper_hangman/core/utils/accent_normalizer.dart';
import 'package:paper_hangman/data/word_repository.dart';

void main() {
  test('accent normalizer matches Brazilian letters without accents', () {
    expect(AccentNormalizer.normalize('açaí'), 'ACAI');
    expect(AccentNormalizer.normalize('coração'), 'CORACAO');
    expect(AccentNormalizer.normalize('pão'), 'PAO');
  });

  test('guessing base letters reveals accented letters', () {
    final controller = GameController(
      wordRepository: _FixedWordRepository('açaí'),
    );

    controller.startGame(Category.brazilianWords);
    controller.guessLetter('a');
    controller.guessLetter('c');
    controller.guessLetter('i');

    expect(controller.visibleCharacters, <String>['A', 'Ç', 'A', 'Í']);
    expect(controller.session?.status, GameStatus.won);
  });
}

class _FixedWordRepository extends WordRepository {
  _FixedWordRepository(this.word);

  final String word;

  @override
  String randomWordFor(Category category) => word;
}
