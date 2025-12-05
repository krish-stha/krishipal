import 'package:flutter/material.dart';
import 'package:krishipal/screens/login_screen.dart';
import 'package:krishipal/screens/onboarding_screen/onboarding_screen3.dart';
import 'package:krishipal/widgets/my_button.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  void _goToNext(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const OnboardingScreen3();
        },
      ),
    );
  }

  void _skipToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              const Spacer(flex: 1),

              Expanded(
                flex: 3,
                child: Center(
                  child: Image.asset(
                    "assets/images/plant.png", // Change image accordingly
                    width: MediaQuery.of(context).size.width * 0.8,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const Spacer(flex: 1),

              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: const Text(
                    'High-Germination Seeds\nYou Can Trust',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3E8B3A),
                      height: 1.3,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: const Text(
                    'Our seeds undergo strict quality testing.\n'
                    'Grow healthier crops with confidence.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(false),
                  const SizedBox(width: 6),
                  _buildDot(true),
                  const SizedBox(width: 6),
                  _buildDot(false),
                ],
              ),

              const Spacer(flex: 2),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextButton(
                      onPressed: () => _skipToLogin(context),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Color(0xFF3E8B3A),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  Flexible(
                    child: MyButton(
                      onPressed: () => _goToNext(context),
                      text: 'Next',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      width: isActive ? 9 : 7,
      height: isActive ? 9 : 7,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF3E8B3A) : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}
