import 'package:flutter/material.dart';

/// Returns the scaffold background color
Color getScaffoldBackgroundColor() {
  return Colors.white; // you can customize this color
}

/// Returns scaffold-specific theme settings
ThemeData applyScaffoldTheme(ThemeData baseTheme) {
  return baseTheme.copyWith(
    scaffoldBackgroundColor: getScaffoldBackgroundColor(),
  );
}
