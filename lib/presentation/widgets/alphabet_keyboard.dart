import 'package:flutter/material.dart';

class AlphabetKeyboard extends StatelessWidget {
  const AlphabetKeyboard({
    super.key,
    required this.disabledLetters,
    required this.onLetterPressed,
  });

  final Set<String> disabledLetters;
  final ValueChanged<String> onLetterPressed;

  static const List<String> _letters = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _letters.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        final letter = _letters[index];
        final isDisabled = disabledLetters.contains(letter);

        return ElevatedButton(
          onPressed: isDisabled ? null : () => onLetterPressed(letter),
          style: ElevatedButton.styleFrom(
            backgroundColor: isDisabled
                ? Theme.of(context).disabledColor.withOpacity(0.12)
                : Theme.of(context).cardColor,
            foregroundColor: isDisabled
                ? Theme.of(context).disabledColor
                : Theme.of(context).colorScheme.primary,
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: Theme.of(context).dividerColor.withOpacity(0.18),
              ),
            ),
          ),
          child: Text(
            letter,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        );
      },
    );
  }
}
