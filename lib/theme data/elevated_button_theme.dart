import 'package:flutter/material.dart';

ElevatedButtonThemeData getElevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF018241),
      foregroundColor: Colors.white,

      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter Regular',
      ),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
  );
}
