import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

/// A service class that handles authentication using Auth0 for both web and mobile platforms.
class AuthService {
  late Auth0 auth0;
  late Auth0Web auth0Web;

  /// Initializes Auth0 with the provided domain and client ID for web and mobile platforms.
  AuthService() {
    /// TODO: Use .env file to store the domain and client ID.
    const String auth0Domain = 'dev-xx77pox0pexsql1p.us.auth0.com';
    const String auth0ClientId = 'L0k3aKFtzuDyH5D0jOhXJKaAQBLd7Id3';

    auth0 = Auth0(
        auth0Domain, auth0ClientId); // Initializes Auth0 for mobile platforms.
    auth0Web = Auth0Web(
        auth0Domain, auth0ClientId); // Initializes Auth0 for web platforms.

    if (kIsWeb) {
      _checkWebSession(); // Checks if the user is already logged in on web.
    }
  }

  /// Checks the session status when the app loads on a web platform and logs the user if found.
  Future<void> _checkWebSession() async {
    final credentials = await auth0Web.onLoad();
    if (credentials != null) {
      print('User logged in: ${credentials.user}');
    }
  }

  /// Initiates the login process for the current platform.
  ///
  /// - On web: Redirects the user to the Auth0 login page.
  /// - On mobile: Logs out the current session (if any) and initiates a new login session.
  Future<void> login() async {
    try {
      developer.log('Login method called');
      if (kIsWeb) {
        await auth0Web.loginWithRedirect(redirectUrl: 'http://localhost:3000');
      } else {
        var credentials = await auth0
            .webAuthentication(scheme: 'com.example.autron')
            .login(useHTTPS: true);

        print('User logged in: ${credentials.user.name}');
      }
    } catch (e) {
      print('Login failed: $e');
    }
  }

  /// Logs out the current session for the platform in use.
  ///
  /// - On web: Redirects to a specified URL after logging out.
  /// - On mobile: Logs out using the specified scheme.
  Future<void> logout() async {
    try {
      if (kIsWeb) {
        await auth0Web.logout(returnToUrl: 'http://localhost:3000');
      } else {
        await auth0
            .webAuthentication(scheme: 'com.example.autron')
            .logout(useHTTPS: true);
        developer.log('User logged out');
      }
    } catch (e) {
      developer.log('Logout failed: $e');
    }
  }
}
