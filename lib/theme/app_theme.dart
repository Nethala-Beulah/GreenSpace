import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFFE8F5E9);
  static const Color background = Color(0xFFF7F9F4);
  static const Color darkGreen = Color(0xFF183D2B);
  static const Color textColor = Color(0xFF243329);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: false,
      ),
      fontFamily: 'Roboto',
    );
  }
}