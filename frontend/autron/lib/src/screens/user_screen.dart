import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user-screen';

  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example user information
    const String userName = "John Doe";
    const String department = "Engineering";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $userName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Department: $department',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
