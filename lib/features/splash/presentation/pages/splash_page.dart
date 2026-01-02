import 'package:flutter/material.dart';
import 'package:krishipal/features/onboarding/onboarding_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _navigateToOnboarding(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const OnboardingPage();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToOnboarding(context);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            "assets/images/logo.png",
            width: 160,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
