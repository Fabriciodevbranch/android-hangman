import 'package:flutter/material.dart';

import '../../application/game_controller.dart';
import '../../core/enums/game_status.dart';
import '../../core/models/game_session.dart';
import '../widgets/alphabet_keyboard.dart';
import '../widgets/hangman_drawing.dart';
import '../widgets/notebook_scaffold.dart';
import '../widgets/paper_button.dart';
import '../widgets/word_display.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({
    super.key,
    required this.controller,
  });

  final GameController controller;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _dialogVisible = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final session = widget.controller.session;
        if (session == null) {
          return NotebookScaffold(
            title: 'Game',
            child: Center(
              child: PaperButton(
                label: 'Back Home',
                icon: Icons.home_rounded,
                expanded: false,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          );
        }

        if (session.status == GameStatus.playing) {
          _dialogVisible = false;
        } else if (!_dialogVisible) {
          _dialogVisible = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showResultDialog(context, session);
          });
        }

        return NotebookScaffold(
          title: session.category.title,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _InfoCard(
                        title: 'Remaining attempts',
                        value:
                            '${session.remainingAttempts}/${session.maxAttempts}',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InfoCard(
                        title: 'Wrong letters',
                        value: widget.controller.wrongLettersSorted.isEmpty
                            ? '—'
                            : widget.controller.wrongLettersSorted.join(' • '),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: <Widget>[
                        HangmanDrawing(wrongAttempts: session.wrongAttempts),
                        const SizedBox(height: 12),
                        WordDisplay(characters: widget.controller.visibleCharacters),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Guessed letters',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.controller.guessedLettersSorted.isEmpty
                              ? 'Pick your first letter.'
                              : widget.controller.guessedLettersSorted.join(' • '),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 18),
                        AlphabetKeyboard(
                          disabledLetters:
                              widget.controller.guessedLettersSorted.toSet(),
                          onLetterPressed: widget.controller.guessLetter,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showResultDialog(
    BuildContext context,
    GameSession session,
  ) async {
    final didWin = session.status == GameStatus.won;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(didWin ? 'You won!' : 'Notebook says try again'),
          content: Text(
            '${didWin ? 'Nice work.' : 'The word got away this time.'}\n\nCorrect word: ${session.originalWord}',
          ),
          actions: <Widget>[
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                widget.controller.resetSession();
                Navigator.of(this.context).popUntil((route) => route.isFirst);
              },
              icon: const Icon(Icons.home_rounded),
              label: const Text('Home'),
            ),
            FilledButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                widget.controller.startGame(session.category);
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Text(
              value,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
