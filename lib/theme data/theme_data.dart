import 'package:flutter/material.dart';
import 'appbar_theme.dart';
import 'bottom_navigation_theme.dart';
import 'elevated_button_theme.dart';
import 'input_decoration_theme.dart';
import 'scaffold_theme.dart';

ThemeData getApplicationTheme() {
  const Color primaryColor = Color(0xFF018241);

  // Base theme
  ThemeData theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter Regular',
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),
    appBarTheme: getAppBarTheme(),
    bottomNavigationBarTheme: getBottomNavigationTheme(),
    elevatedButtonTheme: getElevatedButtonTheme(),
    inputDecorationTheme: getInputDecorationTheme(), // 👈 add this
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primaryColor),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );

  // Apply scaffold theme from scaffold_theme.dart
  theme = applyScaffoldTheme(theme);

  return theme;
}
