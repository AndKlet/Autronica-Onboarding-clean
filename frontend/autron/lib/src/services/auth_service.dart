// auth_service.dart

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:autron/src/services/user_service.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// TODO re-authenticate user on app restart
/// A class that handles authentication.
class AuthService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final UserService _userService = UserService();

  /// Handles the login process.
  ///
  /// This method is called when the user logs in.
  /// It extracts the access token from the response body and stores it securely on device
  Future<String?> handleLogin(
      InAppWebViewController controller, Uri url) async {
    if (url.path.contains('/success')) {
      final accessTokenJson = await controller.evaluateJavascript(
          source: "document.body.innerText");

      if (accessTokenJson != null) {
        final accessToken = jsonDecode(accessTokenJson)['access_token'];
        if (accessToken != null) {
          // print('Access Token Retrieved: $accessToken'); // Debug print
          await storeAccessToken(accessToken);

          // Fetch user data and store email
          final user = await _userService.fetchUserData(accessToken);
          if (user != null) {
            // Accessing the email property from the user object
            await storeUserEmail(user.email); // Store the user's email securely
          }
          return accessToken;
        }
      }
    }
    return null;
  }

  /// Checks if the user is logged in.
  ///
  /// This method is used to determine if the user is logged in upon app start.
  Future<bool> isLoggedIn() async {
    final accessToken = await storage.read(key: 'access_token');
    return accessToken != null;
  }

  /// Stores the access token securely on the device.
  Future<void> storeAccessToken(String accessToken) async {
    await storage.write(key: 'access_token', value: accessToken);
  }

  Future<void> storeUserEmail(String email) async {
    await storage.write(key: 'user_email', value: email); // Save user email
  }

  /// Retrieves the access token from the device's storage.
  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  /// Logs the user out.
  ///
  /// Logs the user out by deleting the access token and clearing user data.
  Future<void> logout() async {
    print('Logging out...');
    await storage.delete(key: 'access_token'); // Remove access token
    await _userService.clearUserData(); // Clear stored user data
  }
}
