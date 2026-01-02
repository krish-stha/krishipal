import 'dart:async';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late PageController _controller;
  int _currentPage = 1000;

  final List<String> banners = [
    'assets/images/plant.jpeg',
    'assets/images/plant2.jpeg',
    'assets/images/plant3.jpeg',
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _currentPage);

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_controller.hasClients) return;

      _currentPage++;
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive height based on screen width
        final double bannerHeight = constraints.maxWidth * 0.45;

        return SizedBox(
          height: bannerHeight.clamp(160, 220), // 📱➡️📱 tablet safe
          child: PageView.builder(
            controller: _controller,
            itemBuilder: (_, index) {
              final imageIndex = index % banners.length;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: 16 / 9, // 🔥 KEY FIX
                    child: Image.asset(
                      banners[imageIndex],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
