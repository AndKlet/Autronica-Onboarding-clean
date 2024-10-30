import 'package:flutter/material.dart';

class RequestAccessIFrame extends StatelessWidget {
  final String softwareName;

  RequestAccessIFrame({required this.softwareName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Access for $softwareName'),
      ),
      body: Center(
        child: Text('Request access form for $softwareName'),
      ),
    );
  }
}
