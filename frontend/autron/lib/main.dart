import 'dart:io';

import 'package:flutter/material.dart';

import 'src/app.dart';


/// NOT FOR PRODUCTION USE
///
/// Install ssl certificicate signed by actual CA on server
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
