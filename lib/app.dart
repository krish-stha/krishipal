import 'package:flutter/material.dart';
import 'theme data/theme_data.dart';
import 'screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wheels',
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      home: const SplashScreen(),
    );
  }
}
