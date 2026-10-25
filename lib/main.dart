import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'screens/explore_screen.dart';
import 'screens/main_navigation_shell.dart';
import 'screens/my_garden_screen.dart';
import 'screens/plant_scanner_screen.dart';
import 'services/garden_state.dart';
=======
import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';
>>>>>>> origin/main
import 'theme/app_theme.dart';

void main() {
  runApp(const GreenSpaceApp());
}

<<<<<<< HEAD
class GreenSpaceApp extends StatefulWidget {
  final GardenState? gardenState;

  const GreenSpaceApp({super.key, this.gardenState});

  @override
  State<GreenSpaceApp> createState() => _GreenSpaceAppState();
}

class _GreenSpaceAppState extends State<GreenSpaceApp> {
  late final GardenState _gardenState;

  @override
  void initState() {
    super.initState();
    _gardenState = widget.gardenState ?? GardenState();
  }

  @override
  void dispose() {
    if (widget.gardenState == null) {
      _gardenState.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GardenStateScope(
      notifier: _gardenState,
      child: MaterialApp(
        title: 'GreenSpace',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const MainNavigationShell(),
        routes: {
          '/explore': (context) => const ExploreScreen(),
          '/garden': (context) => const MyGardenScreen(),
          '/scanner': (context) => const PlantScannerScreen(),
        },
      ),
    );
  }
}
=======
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
>>>>>>> origin/main
