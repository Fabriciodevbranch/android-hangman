import 'package:flutter/material.dart';

import '../../application/game_controller.dart';
import '../../core/models/category.dart';
import '../widgets/notebook_scaffold.dart';
import '../widgets/paper_button.dart';
import 'category_screen.dart';
import 'game_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.controller,
  });

  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return NotebookScaffold(
          title: 'Paper Hangman',
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'A notebook-style hangman with pencil charm.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Selected category',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            controller.selectedCategory == Category.random
                                ? 'Random from all categories'
                                : controller.selectedCategory.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  PaperButton(
                    label: 'Start Game',
                    icon: Icons.play_arrow_rounded,
                    onPressed: () {
                      controller.startGame();
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => GameScreen(controller: controller),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  PaperButton(
                    label: 'Choose Category',
                    icon: Icons.menu_book_rounded,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => CategoryScreen(controller: controller),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  PaperButton(
                    label: 'Settings',
                    icon: Icons.tune_rounded,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => SettingsScreen(controller: controller),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // Reserved space for a future AdMob banner or premium upsell card.
                  const Text(
                    '✏️ cozy • local-only • playable offline',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
