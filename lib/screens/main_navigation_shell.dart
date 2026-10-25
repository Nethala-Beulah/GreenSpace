import 'package:flutter/material.dart';
import '../services/garden_state.dart';
import '../theme/app_theme.dart';
import 'explore_screen.dart';
import 'home_screen.dart';
import 'my_garden_screen.dart';
import 'plant_scanner_screen.dart';

class MainNavigationShell extends StatefulWidget {
  final int initialIndex;

  const MainNavigationShell({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  late int _currentIndex;

  final List<Widget> _screens = const [
    HomeScreen(),
    ExploreScreen(),
    MyGardenScreen(),
    PlantScannerScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final gardenState = GardenStateScope.maybeOf(context);
    final dueCount = gardenState?.wateringRemindersDueCount ?? 0;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: AppTheme.lightGreen,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: AppTheme.primaryGreen),
            label: 'Home',
          ),
          const NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search, color: AppTheme.primaryGreen),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: dueCount > 0,
              label: Text('$dueCount'),
              child: const Icon(Icons.yard_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: dueCount > 0,
              label: Text('$dueCount'),
              child: const Icon(Icons.yard, color: AppTheme.primaryGreen),
            ),
            label: 'My Garden',
          ),
          const NavigationDestination(
            icon: Icon(Icons.center_focus_weak_outlined),
            selectedIcon: Icon(
              Icons.center_focus_strong,
              color: AppTheme.primaryGreen,
            ),
            label: 'Scan & ID',
          ),
        ],
      ),
    );
  }
}
