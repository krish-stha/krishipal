import 'package:flutter/material.dart';
import 'package:krishipal/features/auth/presentation/pages/login_page.dart';
import 'package:krishipal/features/dashboard/presentation/pages/buttom%20navigation%20screen/account_screen.dart';
import 'package:krishipal/features/dashboard/presentation/pages/buttom%20navigation%20screen/blog_screen.dart';
import 'package:krishipal/features/dashboard/presentation/pages/buttom%20navigation%20screen/home_screen.dart';
import 'package:krishipal/features/dashboard/presentation/pages/buttom%20navigation%20screen/shop_screen.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardPage> {
  int _currentIndex = 0;
  int cartCount = 2;

  final screens = const [
    HomeScreen(),
    ShopScreen(),
    BlogScreen(),
    AccountScreen(),
  ];

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('KrishiPal'),
        actions: _currentIndex == 3
            ? [IconButton(icon: const Icon(Icons.logout), onPressed: _logout)]
            : [
                IconButton(
                  icon: const Icon(Icons.notifications_none),
                  onPressed: () {},
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart_outlined),
                      onPressed: () {},
                    ),
                    if (cartCount > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$cartCount',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blogs'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
