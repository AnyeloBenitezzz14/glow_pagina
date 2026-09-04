import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const LuxeBeautyApp());
}

class LuxeBeautyApp extends StatelessWidget {
  const LuxeBeautyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luxe Beauty',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFFAF8),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE96486)),
        fontFamily: 'Georgia',
      ),
      home: const DashboardScreen(),
    );
  }
}
