import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const GreenSpaceApp());
}

class GreenSpaceApp extends StatelessWidget {
  const GreenSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenSpace',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
      routes: {
        '/explore': (context) => const ExploreScreen(),
      },
    );
  }
}