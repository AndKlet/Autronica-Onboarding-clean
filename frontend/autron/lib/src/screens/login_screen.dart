import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(children: [
            const SizedBox(height: 200),
            //logo
            Image.asset('assets/images/autronica-logo.png',
              scale: 2,
            ), 
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  // Login Logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF005E1D),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
          ],
          ),
        ),
      ),
    );
  }
}