import 'dart:io';

import 'package:event_management_app/saved_data.dart';
import 'package:event_management_app/views/checkSessions.dart';
import 'package:event_management_app/views/homepage.dart';
import 'package:event_management_app/views/login.dart';
import 'package:event_management_app/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SavedData.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo app',
        theme: ThemeData.dark(
          useMaterial3: true,
        ).copyWith(textTheme: GoogleFonts.interTextTheme()),
        home: const CheckSessions());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
