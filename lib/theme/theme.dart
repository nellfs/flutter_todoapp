import 'package:flutter/material.dart';

class AppThemes {
  static const Color blue = Color(0xFF1a5fea);
  static const Color outlineBlue = Color(0xFF114abb);

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: blue,
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: outlineBlue),
              borderRadius: BorderRadius.circular(16))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: outlineBlue)));

  static ThemeData darktheme = ThemeData();
}
