import 'package:autron/src/services/auth_service.dart';
import 'package:autron/src/widgets/input_text_field.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Login'),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              // Logo
              Image.asset(
                'assets/images/autronica-logo.png',
                scale: 2,
              ),
              const SizedBox(height: 25),

              // Username text field
              InputTextField(
                  controller: usernameController, hintText: 'Username'),

              const SizedBox(height: 10),

              // Password text field
              InputTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true),

              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                  _authService.login;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF005E1D),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
