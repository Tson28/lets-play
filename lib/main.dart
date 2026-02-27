import 'package:flutter/material.dart';
import 'package:lets_play/screens/splash/splash_screen.dart';
import 'package:lets_play/screens/auth/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Let\'s Play',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6B48FF)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}