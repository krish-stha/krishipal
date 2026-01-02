import 'package:flutter/material.dart';
import 'package:krishipal/app/theme/app_theme.dart';
import 'package:krishipal/features/splash/presentation/pages/splash_page.dart';

class Krishipal extends StatelessWidget {
  const Krishipal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost & Found',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
