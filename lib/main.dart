import 'package:flutter/material.dart';
import 'screens/explore_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/plant_form_screen.dart';
import 'screens/journal_form_screen.dart';
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/explore': (context) => const ExploreScreen(),
        '/plant/add': (context) => PlantFormScreen(
          initialData:
              ModalRoute.of(context)?.settings.arguments as PlantFormData?,
        ),
        '/plant/edit': (context) => PlantFormScreen(
          initialData:
              ModalRoute.of(context)?.settings.arguments as PlantFormData?,
        ),
        '/journal/add': (context) => const JournalFormScreen(),
      },
    );
  }
}
