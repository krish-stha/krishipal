import 'package:flutter/material.dart';

BottomNavigationBarThemeData getBottomNavigationTheme() {
  const Color primaryColor = Color(0xFF018241);

  return const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,

    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.grey,

    showSelectedLabels: true,
    showUnselectedLabels: true,

    selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),

    type: BottomNavigationBarType.fixed,
    elevation: 8,
  );
}
