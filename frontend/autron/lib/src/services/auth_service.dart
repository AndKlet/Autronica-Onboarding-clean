// auth_service.dart

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:autron/src/services/user_service.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AuthService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final UserService _userService = UserService();

  // Method to handle the login process and extract the access token
  Future<String?> handleLogin(InAppWebViewController controller, Uri url) async {
    if (url.path.contains('/success')) {
      // Extract access token from the response body
      final accessTokenJson = await controller.evaluateJavascript(
          source: "document.body.innerText");

      if (accessTokenJson != null) {
        final accessToken = jsonDecode(accessTokenJson)['access_token'];
        if (accessToken != null) {
          // print('Access Token Retrieved: $accessToken'); // Debug print
          await storeAccessToken(accessToken);
          await _userService.fetchUserData(accessToken); // Fetch and store user data
          return accessToken;
        }
      }
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    final accessToken = await storage.read(key: 'access_token');
    return accessToken != null;
  }

  // Store the access token securely
  Future<void> storeAccessToken(String accessToken) async {
    await storage.write(key: 'access_token', value: accessToken);
  }

  // Retrieve the access token from secure storage
  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<void> logout() async {
    print('Logging out...');
    await storage.delete(key: 'access_token'); // Remove the token on logout
    await _userService.clearUserData(); // Clear stored user data
  }
}
