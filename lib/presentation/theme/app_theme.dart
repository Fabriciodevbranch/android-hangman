import 'package:flutter/material.dart';

class AppTheme {
  static const Color _paper = Color(0xFFF8F1E3);
  static const Color _paperShadow = Color(0xFFE4D5BC);
  static const Color _ink = Color(0xFF4A4032);
  static const Color _pencil = Color(0xFF786655);
  static const Color _nightPaper = Color(0xFF222A36);
  static const Color _nightCard = Color(0xFF2C3644);
  static const Color _nightInk = Color(0xFFE6E1D5);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _paper,
      colorScheme: const ColorScheme.light(
        primary: _ink,
        secondary: _pencil,
        surface: Colors.white,
      ),
      cardColor: const Color(0xFFFFFBF4),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: _ink,
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: _ink,
          letterSpacing: 0.6,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: _ink,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          height: 1.4,
          color: _ink,
        ),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFFFFFBF4),
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: _paperShadow, width: 1.2),
        ),
      ),
      useMaterial3: false,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _nightPaper,
      colorScheme: const ColorScheme.dark(
        primary: _nightInk,
        secondary: Color(0xFFB8A48A),
        surface: _nightCard,
      ),
      cardColor: _nightCard,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: _nightInk,
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: _nightInk,
          letterSpacing: 0.6,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: _nightInk,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          height: 1.4,
          color: _nightInk,
        ),
      ),
      cardTheme: CardTheme(
        color: _nightCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0xFF465264), width: 1.2),
        ),
      ),
      useMaterial3: false,
    );
  }
}
