import 'package:autron/src/services/auth_service.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
  const UserScreen({super.key});
}

class _UserScreenState extends State<UserScreen> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    // Example user information
    const String userName = "John Doe";
    const String department = "Engineering";

    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name: $userName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Department: $department',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                    _authService.login;
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
        ),
      ),
    );
  }
}
