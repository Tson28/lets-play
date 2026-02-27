import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sports_esports, size: 80, color: Color(0xFF6B48FF)),
          SizedBox(height: 20),
          Text(
            "Trang chủ",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B48FF),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Chào mừng bạn đến với Let's Play!",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
