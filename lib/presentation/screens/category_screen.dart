import 'package:flutter/material.dart';

import '../../application/game_controller.dart';
import '../../core/models/category.dart';
import '../widgets/notebook_scaffold.dart';
import '../widgets/paper_button.dart';
import 'game_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
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
          title: 'Choose Category',
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  itemCount: Category.values.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final category = Category.values[index];
                    final isSelected = controller.selectedCategory == category;

                    return Card(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () => controller.selectCategory(category),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                isSelected
                                    ? Icons.check_circle_rounded
                                    : Icons.circle_outlined,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  category.title,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              Text(
                                category == Category.random
                                    ? 'All lists'
                                    : 'Local words',
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              PaperButton(
                label: 'Start Selected Game',
                icon: Icons.play_arrow_rounded,
                onPressed: () {
                  controller.startGame(controller.selectedCategory);
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => GameScreen(controller: controller),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
