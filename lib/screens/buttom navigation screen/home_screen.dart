import 'package:flutter/material.dart';
import 'package:krishipal/widgets/banner_slider.dart';
import 'package:krishipal/widgets/category_list.dart';
import 'package:krishipal/widgets/product_grid.dart';
import 'package:krishipal/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          HomeSearchBar(),
          SizedBox(height: 20),
          BannerSlider(),
          SizedBox(height: 24),
          CategoryList(),
          SizedBox(height: 24),
          ProductGrid(),
        ],
      ),
    );
  }
}
