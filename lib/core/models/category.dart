class Category {
  final String id;
  final String title;

  const Category._(this.id, this.title);

  static const animals = Category._('animals', 'Animals');
  static const countries = Category._('countries', 'Countries');
  static const tech = Category._('tech', 'Tech');
  static const brazilianWords =
      Category._('brazilian_words', 'Brazilian Words');
  static const random = Category._('random', 'Random');

  static const values = <Category>[
    animals,
    countries,
    tech,
    brazilianWords,
    random,
  ];

  static const selectableValues = <Category>[
    animals,
    countries,
    tech,
    brazilianWords,
  ];

  @override
  String toString() => title;
}
