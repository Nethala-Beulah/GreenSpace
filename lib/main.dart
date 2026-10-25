import 'package:flutter/material.dart';
import 'screens/explore_screen.dart';
import 'screens/main_navigation_shell.dart';
import 'screens/my_garden_screen.dart';
import 'screens/plant_scanner_screen.dart';
import 'services/garden_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const GreenSpaceApp());
}

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
