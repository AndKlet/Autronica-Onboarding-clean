import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Logo
            Image.asset(
              'assets/images/autronica-logo.png',
              scale: 2,
            ),
            const SizedBox(height: 5),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri('https://164.92.218.9/accounts/login/')),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStop: (controller, url) {
                  print('Page finished loading: $url');
                },
                onLoadStart: (controller, url) {
                  print('Page started loading: $url');
                },
                onReceivedHttpError: (controller, request, error) {
                  print('HTTP error: $error');
                },
                onReceivedServerTrustAuthRequest: (controller, challenge) async {
                  // Handle SSL bypass for development
                  return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
