import 'package:autron/src/app.dart';
import 'package:autron/src/screens/login_screen.dart';
import 'package:autron/src/services/auth_service.dart';
import 'package:autron/src/services/user_service.dart';
import 'package:autron/src/view_models/user_model.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:flutter/material.dart';

/// The UserScreen widget displays the user profile screen of the application.
/// 
/// The user profile screen displays the user's name and department, and allows the user to log out.
/// UserScreen fetches user data from the [UserService].
class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
  const UserScreen({super.key});
}

class _UserScreenState extends State<UserScreen> {
  final AuthService _authService = AuthService(); // Use AuthService
  final UserService _userService = UserService(); // Use UserService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<User?>(
          future: _userService.getUserData(),
          builder: (context, snapshot) {
            // Check the connection state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading user data'));
            } else if (!snapshot.hasData) {
              // If no user data, navigate to LoginPage
              Future.microtask(() {
                (context as Element)
                    .findAncestorStateOfType<MyAppState>()!
                    .hideBottomNav(true);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              });
              return const SizedBox();
            } else {
              final user = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${user.name}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // const Text(
                  //   'Department: Engineering',
                  //   style: TextStyle(fontSize: 20),
                  // ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          (context as Element)
                              .findAncestorStateOfType<MyAppState>()!
                              .hideBottomNav(true);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                          _authService.logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF005E1D),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
