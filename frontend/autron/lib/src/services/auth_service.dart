import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:http/http.dart' as http;

/// A service class that handles authentication.
class AuthService {
  AuthService();

  /// Initiates the login process for the current platform.
  ///
  /// - On web: Redirects the user to the Auth0 login page.
  /// - On mobile: Logs out the current session (if any) and initiates a new login session.
  Future<void> login() async {
    print('Logging in...');
  }

  /// Logs out the current session for the platform in use.
  ///
  /// - On web: Redirects to a specified URL after logging out.
  /// - On mobile: Logs out using the specified scheme.
  Future<void> logout() async {
    print('Logging out...');
  }
}

  /// Fetches user data using the provided access token.
  /// 
  /// - [accessToken]: The access token to use for fetching user data.
  Future<void> fetchUserData(String accessToken) async {
  final url = Uri.parse('https://164.92.218.9/get_user_data/');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $accessToken',  // Send token in Authorization header
    },
  );

  if (response.statusCode == 200) {
    final userData = jsonDecode(response.body);
    print('User Data Retrieved: $userData');
  } else {
    print('Failed to fetch user data: ${response.statusCode}');
  }
}
