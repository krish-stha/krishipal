import 'dart:async';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late PageController _controller;
  int _currentPage = 1000; // large number for infinite feel

  final List<String> banners = [
    'assets/images/banner1.jpg',
    'assets/images/Banner2.jpg', // keep lowercase
    'assets/images/banner3.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _currentPage);

    Timer.periodic(const Duration(seconds: 3), (timer) {
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: PageView.builder(
        controller: _controller,
        itemBuilder: (_, index) {
          final imageIndex = index % banners.length;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(banners[imageIndex], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
