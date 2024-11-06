import 'package:autron/src/app.dart';
import 'package:autron/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:autron/globals/urls.dart';


/// The LoginPage widget displays the login screen of the application.
/// 
/// The login screen fetches user data from the [AuthService] and allows the user to log in.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late InAppWebViewController webViewController;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.asset(
              'assets/images/autronica-logo.png',
              scale: 3,
            ),
            const SizedBox(height: 5),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                    url: WebUri('${Urls.baseUrl}/accounts/login/')),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onReceivedServerTrustAuthRequest: (controller, challenge) async {
                  // Bypass SSL for testing purposes - should be removed in production (Have a valid SSL certificate)
                  return ServerTrustAuthResponse(
                      action: ServerTrustAuthResponseAction.PROCEED);
                },
                onLoadStop: (controller, url) async {
                  if (url != null) {
                    print('Page finished loading: $url');

                    // Use AuthService to handle login and extract access token
                    final accessToken = await _authService.handleLogin(controller, url);

                    if (accessToken != null) {
                      // Show the bottom navigation bar and navigate to the home screen
                      (context as Element)
                          .findAncestorStateOfType<MyAppState>()!
                          .hideBottomNav(true);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()));
                    } else {
                      print('Error: Access token not found in JSON response');
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}