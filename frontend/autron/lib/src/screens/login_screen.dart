import 'dart:convert';
import 'package:autron/src/app.dart';
import 'package:autron/src/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late InAppWebViewController webViewController;
  final storage = FlutterSecureStorage();

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
              scale: 2,
            ),
            const SizedBox(height: 5),
            Expanded(
              child: InAppWebView(
                  initialUrlRequest: URLRequest(
                      url: WebUri('https://164.92.218.9/accounts/login/')),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onReceivedServerTrustAuthRequest:
                      (controller, challenge) async {
                    // Bypass SSL for testing purposes
                    return ServerTrustAuthResponse(
                        action: ServerTrustAuthResponseAction.PROCEED);
                  },
                  onLoadStop: (controller, url) async {
                    print('Page finished loading: $url');

                    if (url != null && url.path.contains('/success')) {
                      // Execute JavaScript to extract the JSON response
                      final accessTokenJson =
                          await controller.evaluateJavascript(
                              source: "document.body.innerText");

                      if (accessTokenJson != null) {
                        // Decode the JSON response and extract the access token
                        final accessToken =
                            jsonDecode(accessTokenJson)['access_token'];

                        if (accessToken != null) {
                          print(
                              'Access Token Retrieved: $accessToken'); // Debug print to confirm token retrieval

                          // Store the token securely
                          await storage.write(
                              key: 'access_token', value: accessToken);

                          // Verify that the token is stored
                          String? storedToken =
                              await storage.read(key: 'access_token');
                          print(
                              'Stored Token: $storedToken'); // This should match the retrieved token

                          // Show the bottom navigation bar and navigate to the home screen
                          // Show the bottom navigation bar
        (context as Element).findAncestorStateOfType<MyAppState>()!.hideBottomNav(false);

        // Update the selected index in MyAppState to switch to the home tab
        (context as Element).findAncestorStateOfType<MyAppState>()!.onItemTapped(0);
                        } else {
                          print(
                              'Error: Access token not found in JSON response');
                        }
                      } else {
                        print(
                            'Error: Failed to retrieve access token JSON response');
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
