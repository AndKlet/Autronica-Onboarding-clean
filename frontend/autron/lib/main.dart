import 'dart:io';

import 'package:flutter/material.dart';

import 'src/app.dart';


/// A custom HTTP overrides class that bypasses SSL certificate verification.
///
/// **NOT FOR PRODUCTION USE** This class is meant for development and testing
/// purposes only. It allows bypassing certificate verification, which should
/// not be done in production environments. Install a valid SSL certificate in
/// a production environment.
 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}
