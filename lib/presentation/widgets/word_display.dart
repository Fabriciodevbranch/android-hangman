import 'package:flutter/material.dart';

class WordDisplay extends StatelessWidget {
  const WordDisplay({
    super.key,
    required this.characters,
  });

  final List<String> characters;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: characters.map((character) {
        final isHidden = character == '_';

        return Container(
          width: 42,
          height: 52,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(0.2),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            character,
            style: TextStyle(
              fontSize: isHidden ? 28 : 24,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      }).toList(growable: false),
    );
  }
}
