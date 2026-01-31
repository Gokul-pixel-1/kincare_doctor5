import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF5E60CE);
  static const Color secondary = Color(0xFF48BFE3);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: false, // IMPORTANT

    primaryColor: primary,
    scaffoldBackgroundColor: const Color(0xFFF7F7FB),

    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    // ✅ FIXED: use CardThemeData
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}