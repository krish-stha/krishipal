import 'package:flutter/material.dart';
import 'package:krishipal/features/auth/presentation/pages/login_page.dart';

import 'package:krishipal/features/auth/presentation/widgets/my_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      image: "assets/images/image.png",
      title: "Find Quality Seeds\nfor Better Harvest",
      description:
          "Explore a wide range of vegetable and crop seeds.\nChoose high-quality seeds for healthy growth.",
    ),
    _OnboardingData(
      image: "assets/images/plant.png",
      title: "High-Germination Seeds\nYou Can Trust",
      description:
          "Our seeds undergo strict quality testing.\nGrow healthier crops with confidence.",
    ),
    _OnboardingData(
      image: "assets/images/delivery.png",
      title: "Order Easily & Get\nSeeds Delivered Fast",
      description:
          "Browse, select, and order seeds in seconds.\nWe deliver fresh seeds to your doorstep.",
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7F5),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // Top white system bar
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).padding.top,
          ),

          const SizedBox(height: 10),

          // -------- PAGE VIEW --------
          Expanded(
            flex: 4,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (_, index) {
                final page = _pages[index];
                return Padding(
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
                        page.image,
                        width: MediaQuery.of(context).size.width * 0.75,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 25),

          // -------- TEXT --------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  _pages[_currentPage].title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3E8B3A),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _pages[_currentPage].description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // -------- DOTS --------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildDot(index == _currentPage),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // -------- BUTTONS --------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _currentPage == _pages.length - 1
                ? MyButton(onPressed: _goToLogin, text: "Get Started")
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _goToLogin,
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            color: Color(0xFF3E8B3A),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      MyButton(onPressed: _nextPage, text: "Next"),
                    ],
                  ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _OnboardingData {
  final String image;
  final String title;
  final String description;

  const _OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
