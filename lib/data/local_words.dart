import '../core/models/category.dart';

class LocalWords {
  static const Map<String, List<String>> byCategory = <String, List<String>>{
    'animals': <String>[
      'capybara',
      'butterfly',
      'otter',
      'penguin',
      'jaguar',
      'rabbit',
      'koala',
      'turtle',
    ],
    'countries': <String>[
      'brazil',
      'canada',
      'japan',
      'mexico',
      'norway',
      'india',
      'italy',
      'angola',
    ],
    'tech': <String>[
      'android',
      'laptop',
      'router',
      'keyboard',
      'widget',
      'server',
      'binary',
      'docker',
    ],
    'brazilian_words': <String>[
      'açaí',
      'coração',
      'paçoca',
      'limão',
      'pão',
      'avião',
      'maçã',
      'café',
    ],
  };

  static List<String> get wordsForRandomCategory {
    return Category.selectableValues
        .expand((category) => byCategory[category.id] ?? const <String>[])
        .toList(growable: false);
  }
}
