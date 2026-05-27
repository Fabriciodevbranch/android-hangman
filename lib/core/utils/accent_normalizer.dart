class AccentNormalizer {
  static const Map<String, String> _replacements = <String, String>{
    'Á': 'A',
    'À': 'A',
    'Ã': 'A',
    'Â': 'A',
    'Ä': 'A',
    'É': 'E',
    'È': 'E',
    'Ê': 'E',
    'Ë': 'E',
    'Í': 'I',
    'Ì': 'I',
    'Î': 'I',
    'Ï': 'I',
    'Ó': 'O',
    'Ò': 'O',
    'Õ': 'O',
    'Ô': 'O',
    'Ö': 'O',
    'Ú': 'U',
    'Ù': 'U',
    'Û': 'U',
    'Ü': 'U',
    'Ç': 'C',
  };

  static String normalize(String value) {
    return value
        .toUpperCase()
        .split('')
        .map((character) => _replacements[character] ?? character)
        .join();
  }

  static bool isGuessableLetter(String character) {
    return RegExp(r'^[A-Z]$').hasMatch(normalize(character));
  }
}
