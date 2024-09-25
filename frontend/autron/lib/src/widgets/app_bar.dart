import 'package:flutter/material.dart';

class AppBarExample extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarExample({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 28, // Increase the font size
            color: Color(
                0xFF005E1D), // Set the text color to green (hex code for green)
            fontWeight: FontWeight.bold, // Optional: make it bold
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 240, 243, 241),
        actions: [
          IconButton(
            icon: Image.asset('assets/images/autronica-logo-small.png'),
            onPressed: null,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
