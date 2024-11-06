import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RequestAccessWebview extends StatefulWidget {
  final String softwareName;
  final String url;

  const RequestAccessWebview(
      {super.key, required this.softwareName, required this.url});

  @override
  State<RequestAccessWebview> createState() => _RequestAccessWebviewState();
}

class _RequestAccessWebviewState extends State<RequestAccessWebview> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    // Note: WebView.platform = SurfaceAndroidWebView(); is no longer needed in newer versions

    return Scaffold(
      appBar: AppBar(
        title: Text('Request Access for ${widget.softwareName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebViewWidget(
              controller: controller,
            ),
          )
        ],
      ),
    );
  }
}
