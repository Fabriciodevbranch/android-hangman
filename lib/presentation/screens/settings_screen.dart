import 'package:flutter/material.dart';

import '../../application/game_controller.dart';
import '../widgets/notebook_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
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
          title: 'Settings',
          child: ListView(
            children: <Widget>[
              Card(
                child: SwitchListTile(
                  title: const Text('Sound'),
                  subtitle: const Text('Toggle cozy pencil sounds on or off.'),
                  value: controller.isSoundEnabled,
                  onChanged: controller.updateSoundEnabled,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: SwitchListTile(
                  title: const Text('Night notebook mode'),
                  subtitle: const Text('Use a darker paper palette for evening play.'),
                  value: controller.isNightModeEnabled,
                  onChanged: controller.updateNightMode,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: const Text('Themes'),
                  subtitle: const Text(
                    'Premium and seasonal notebook themes can be added here later.',
                  ),
                  trailing: const Icon(Icons.palette_outlined),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
