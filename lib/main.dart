import 'package:flutter/material.dart';
import 'package:netflix/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        // scaffoldBackgroundColor: Colors.grey[900],
        brightness: Brightness.dark,

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[800],
          elevation: 0,
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Updated to bodyMedium
        ),
      ),
      home: SplashScreen(),
    );
  }
}



