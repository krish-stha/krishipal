import 'package:flutter/material.dart';
import 'package:krishipal/screens/login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: const Color(0xFF0B7A32), // Updated color
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Welcome to",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your Dashboard",
                    style: TextStyle(
                      fontSize: 32,
                      color: Color(0xFF0B7A32), // Updated color
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black26,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B7A32), // Updated color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _logout(context);
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
