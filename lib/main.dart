import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';

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
      home: Builder(
        builder: (context) => LoginScreen(
          onSignIn: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const DashboardScreen()),
          ),
          onCreateAccount: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Create account coming soon')),
          ),
          onForgotPassword: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password recovery coming soon')),
          ),
        ),
      ),
    );
  }
}
