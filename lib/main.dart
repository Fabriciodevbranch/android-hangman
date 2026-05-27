import 'package:flutter/material.dart';

import 'application/game_controller.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  runApp(const PaperHangmanApp());
}

class PaperHangmanApp extends StatefulWidget {
  const PaperHangmanApp({super.key});

  @override
  State<PaperHangmanApp> createState() => _PaperHangmanAppState();
}

class _PaperHangmanAppState extends State<PaperHangmanApp> {
  late final GameController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GameController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Paper Hangman',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _controller.isNightModeEnabled
              ? ThemeMode.dark
              : ThemeMode.light,
          home: HomeScreen(controller: _controller),
        );
      },
    );
  }
}
