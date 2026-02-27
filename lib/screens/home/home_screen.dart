import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's Play"),
        backgroundColor: const Color(0xFF6B48FF),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          "Welcome to Let's Play!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
