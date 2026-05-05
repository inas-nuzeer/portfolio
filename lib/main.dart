import 'package:flutter/material.dart';
import 'package:inas_portfolio/Screens/Splash/splash_screen.dart';
import 'package:inas_portfolio/Utils/Theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inas Nuzeer Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
