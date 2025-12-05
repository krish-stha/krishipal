import 'package:flutter/material.dart';
import 'package:krishipal/screens/login_screen.dart';
import 'package:krishipal/widgets/my_button.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  void _goToLogin(BuildContext context) {
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
                    "assets/images/delivery.png", // Change image accordingly
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
                    'Order Easily & Get \nSeeds Delivered Fast',
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
                    'Browse, select, and order seeds in seconds.\n'
                    'We deliver fresh and quality seeds to your doorstep.',
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
                  _buildDot(false),
                  const SizedBox(width: 6),
                  _buildDot(true),
                ],
              ),

              const Spacer(flex: 2),

              MyButton(
                onPressed: () => _goToLogin(context),
                text: 'Get Started',
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
