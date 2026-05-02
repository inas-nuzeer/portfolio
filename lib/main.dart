import 'package:flutter/material.dart';
import 'package:inas_portfolio/Screens/MainContent/main_content.dart';
import 'package:inas_portfolio/Utils/Theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inas Nuzeer Portfolio',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      theme: AppTheme.lightTheme,
      home: const MainContent(),
    );
  }
}
