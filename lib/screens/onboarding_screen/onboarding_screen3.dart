import 'package:flutter/material.dart';
import 'package:krishipal/screens/login_screen.dart';
import 'package:krishipal/widgets/my_button.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  void _goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7F5),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // White top system bar
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).padding.top,
          ),

          const SizedBox(height: 10),

          // ---------- IMAGE SECTION WITH 3D CARD ----------
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    "assets/images/delivery.png",
                    width: MediaQuery.of(context).size.width * 0.75,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          // ---------- HEADLINE ----------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: const [
                Text(
                  'Order Easily & Get \nSeeds Delivered Fast',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3E8B3A),
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Browse, select, and order seeds in seconds.\n'
                  'We deliver fresh and quality seeds to your doorstep.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ---------- DOT INDICATOR ----------
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

          const SizedBox(height: 30),

          // ---------- GET STARTED BUTTON ----------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: MyButton(
              onPressed: () => _goToLogin(context),
              text: 'Get Started',
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      width: isActive ? 10 : 8,
      height: isActive ? 10 : 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF3E8B3A) : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}
