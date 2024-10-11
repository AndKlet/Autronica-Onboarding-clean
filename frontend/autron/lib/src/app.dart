import 'package:flutter/material.dart';
import 'package:autron/src/screens/request_screen.dart';
import 'package:autron/src/screens/home.dart';
import 'package:autron/src/screens/login_screen.dart';
import 'package:autron/src/screens/user_screen.dart';
import 'package:autron/src/screens/software_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _selectedIndex = 0;
  final _screens = [
    HomeScreen(),
    const SoftwarePage(),
    RequestScreen(),
    const UserScreen(),
  ];

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => const MyApp(),
        '/login': (context) => const LoginPage(),
        '/software': (context) => const SoftwarePage(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
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
        ),
      ),
    );
  }

  // Custom method to build BottomNavigationBarItem
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
