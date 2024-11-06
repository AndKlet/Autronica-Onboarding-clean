import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:autron/src/screens/request_screen.dart';
import 'package:autron/src/screens/home.dart';
import 'package:autron/src/screens/login_screen.dart';
import 'package:autron/src/screens/user_screen.dart';
import 'package:autron/src/screens/software_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  bool _showBottomNav = true; // Control whether the bottom nav bar is shown

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final _screens = [
    HomeScreen(),
    const SoftwarePage(),
    RequestScreen(),
    const UserScreen(),
    const LoginPage(),
  ];

  // Handle tab switching and show the bottom nav
  void _onItemTapped(int index) {
    setState(() {
      // Reset the Software tab by recreating its Navigator key
      if (index == 1) {
        _navigatorKeys[1] = GlobalKey<NavigatorState>();
      }
      _selectedIndex = index;
      _showBottomNav = true; // Always show bottom nav when switching tabs
    });
  }

  // Hide bottom nav on certain sub-pages
  void hideBottomNav(bool shouldHide) {
    setState(() {
      _showBottomNav = !shouldHide;
    });
  }

  // Create individual navigators for each tab
  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => _screens[index],
          );
        },
      ),
    );
  }

  // Handle back button presses within each tab's navigation stack
  Future<bool> _onWillPop() async {
    final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_selectedIndex].currentState!.maybePop();
    if (isFirstRouteInCurrentTab) {
      // If the user is on the first route of the tab, allow the app to exit
      return true;
    }
    // Otherwise, just pop the current route
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: WillPopScope(
        onWillPop: _onWillPop, // Handle back button behavior for tabs
        child: Scaffold(
          body: Stack(
            children: [
              _buildOffstageNavigator(0),
              _buildOffstageNavigator(1),
              _buildOffstageNavigator(2),
              _buildOffstageNavigator(3),
            ],
          ),
          bottomNavigationBar: _showBottomNav
              ? BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: const Color(0xFF005E1D),
                  backgroundColor: const Color(0xFFF9F9F9),
                  type: BottomNavigationBarType.fixed,
                  items: [
                    _buildBottomNavItem(
                      icon: Icons.home,
                      label: 'Home',
                      index: 0,
                      isSelected: _selectedIndex == 0,
                    ),
                    _buildBottomNavItem(
                      icon: Icons.my_library_add,
                      label: 'Software',
                      index: 1,
                      isSelected: _selectedIndex == 1,
                    ),
                    _buildBottomNavItem(
                      icon: Icons.assignment,
                      label: 'Requests',
                      index: 2,
                      isSelected: _selectedIndex == 2,
                    ),
                    _buildBottomNavItem(
                      icon: Icons.account_circle,
                      label: 'Profile',
                      index: 3,
                      isSelected: _selectedIndex == 3,
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[300] : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected
                  ? const Color.fromARGB(255, 0, 0, 0)
                  : const Color(0xFF005E1D),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : const Color(0xFF005E1D),
              ),
            ),
          ],
        ),
      ),
      label: '',
    );
  }
}
