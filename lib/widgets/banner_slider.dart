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

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
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
    return SizedBox(
      height: 260, // ⬅️ banner-style height
      child: PageView.builder(
        controller: _controller,
        itemBuilder: (_, index) {
          final imageIndex = index % banners.length;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  banners[imageIndex],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
