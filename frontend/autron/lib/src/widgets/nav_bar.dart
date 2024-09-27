import 'package:autron/src/screens/home.dart';
import 'package:autron/src/screens/login_screen.dart';
import 'package:autron/src/screens/software_screen.dart';

import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.add_circle_outline),
          label: 'Software',
        ),
        NavigationDestination(
          icon: Icon(Icons.assignment),
          label: 'Requests',
        ),
        NavigationDestination(
          icon: Icon(Icons.account_circle),
          label: 'User',
        ),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: (int index) {
        switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LoginPage();
            }));
            break;
          case 1:
            Navigator.pushNamed(context, '/settings');
            break;
          case 2:
            Navigator.pushNamed(context, '/left');
            break;
          case 3:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SoftwarePage();
            }));
            break;
        }
      },
    );
  }
}
