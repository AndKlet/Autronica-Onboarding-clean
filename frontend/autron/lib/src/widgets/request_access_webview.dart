import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RequestAccessWebview extends StatelessWidget {
  final String softwareName;
  final String url;

  RequestAccessWebview({required this.softwareName, required this.url});

  @override
  Widget build(BuildContext context) {
    // Ensure the WebView is initialized for Android
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Request Access for $softwareName'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              softwareName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
    );
  }
}
