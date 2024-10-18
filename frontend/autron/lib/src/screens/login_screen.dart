import 'package:autron/globals/theme/app_colors.dart';
import 'package:autron/src/app.dart';
import 'package:autron/src/services/auth_service.dart';
import 'package:autron/src/widgets/input_text_field.dart';
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
      backgroundColor: AppColors.autronWhite,
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
                  (context as Element).findAncestorStateOfType<MyAppState>()!
                              .hideBottomNav(false);
                  Navigator.pushReplacementNamed(context, '/home');
                  _authService.login;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.autronGreen,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: AppColors.autronWhite,
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
