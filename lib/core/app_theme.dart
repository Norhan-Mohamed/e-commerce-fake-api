import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xfff7f7f8),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xfff7f7f8),
      elevation: 0,
      foregroundColor: Colors.black,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
