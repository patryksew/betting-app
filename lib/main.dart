import 'package:flutter/material.dart';
import 'package:fuksiarz/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patryk Sewastianowicz Fuksiarz',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      ),
      home: const MainScreen(),
    );
  }
}
