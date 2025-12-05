import 'package:flutter/material.dart';
import 'package:krishipal/screens/login_screen.dart';
import 'package:krishipal/widgets/my_button.dart';
import 'package:krishipal/screens/onboarding_screen/onboarding_screen2.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  void _goToNext(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const OnboardingScreen2();
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

              // IMAGE SECTION
              Expanded(
                flex: 3,
                child: Center(
                  child: Image.asset(
                    "assets/images/image.png",
                    width: MediaQuery.of(context).size.width * 0.8,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const Spacer(flex: 1),

              // HEADLINE
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: const Text(
                    'Find Quality Seeds\nfor Better Harvest',
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

              // DESCRIPTION
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: const Text(
                    'Explore a wide range of vegetable and crop seeds.\n'
                    'Choose the best quality for healthy and fresh growth.',
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

              // DOT INDICATOR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(true),
                  const SizedBox(width: 6),
                  _buildDot(false),
                  const SizedBox(width: 6),
                  _buildDot(false),
                ],
              ),

              const Spacer(flex: 2),

              // BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        _skipToLogin(context);
                      },
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
                      onPressed: () {
                        _goToNext(context);
                      },
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
