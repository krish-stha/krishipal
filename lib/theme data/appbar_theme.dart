import 'package:flutter/material.dart';

AppBarTheme getAppBarTheme() {
  return const AppBarTheme(
    centerTitle: true,

    // Material 3 prefers flat app bars
    elevation: 0,
    scrolledUnderElevation: 4,

    backgroundColor: Color(0xFF018241),
    shadowColor: Colors.black,

    titleTextStyle: TextStyle(
      fontFamily: 'Inter Bold',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),

    iconTheme: IconThemeData(color: Colors.white),
  );
}
