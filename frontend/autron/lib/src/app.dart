import 'package:autron/src/screens/request_screen.dart';
import 'package:autron/src/screens/home.dart';
import 'package:autron/src/screens/login_screen.dart';
import 'package:autron/src/screens/user_screen.dart';
import 'package:autron/src/screens/software_screen.dart';
import 'package:flutter/material.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

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

        // Navigation bar theme
        theme: ThemeData(
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: const Color(0xFFF9F9F9),
            indicatorColor: const Color.fromARGB(90, 0, 0, 0),
            indicatorShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius
                  .zero, // Removes rounded corners to make it rectangular
            ),
            labelTextStyle: WidgetStateProperty.all(
              const TextStyle(color: Color(0xFF005E1D)),
            ),
            iconTheme: WidgetStateProperty.all(
              const IconThemeData(color: Color(0xFF005E1D)),
            ),
          ),
        ),
        home: Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            backgroundColor: const Color(0xFFF9F9F9),
            indicatorColor: const Color.fromARGB(90, 0, 0, 0),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home, color: Color(0xFF005E1D)),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.add_circle_outline, color: Color(0xFF005E1D)),
                label: 'Software',
              ),
              NavigationDestination(
                icon: Icon(Icons.assignment, color: Color(0xFF005E1D)),
                label: 'Requests',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle, color: Color(0xFF005E1D)),
                label: 'User',
              ),
            ],
          ),
        ));
  }
}
