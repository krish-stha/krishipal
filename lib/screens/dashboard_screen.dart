import 'package:flutter/material.dart';
import 'package:krishipal/screens/login_screen.dart';
import 'buttom navigation screen/home_screen.dart';
import 'buttom navigation screen/shop_screen.dart';
import 'buttom navigation screen/blog_screen.dart';
import 'buttom navigation screen/account_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ShopScreen(),
    const BlogScreen(),
    const AccountScreen(),
  ];

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? "Home"
              : _currentIndex == 1
              ? "Shop"
              : _currentIndex == 2
              ? "Blogs"
              : "Profile",
        ),
        backgroundColor: const Color(0xFF0B7A32),
        actions: _currentIndex == 3
            ? [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => _logout(context),
                ),
              ]
            : null,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0B7A32),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop_2_outlined),
            activeIcon: Icon(Icons.shop),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online_outlined),
            activeIcon: Icon(Icons.book),
            label: 'Blogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
