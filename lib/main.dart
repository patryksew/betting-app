import 'package:flutter/material.dart';
import 'package:fuksiarz/screens/main_screen/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

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
        primaryColor: const Color.fromRGBO(198, 40, 40, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(248, 248, 248, 1),
          elevation: 0,
        ),
        dividerColor: const Color.fromRGBO(227, 232, 239, 1),
        scaffoldBackgroundColor: const Color.fromRGBO(248, 248, 248, 1),
        textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.black)),
        textTheme: GoogleFonts.montserratTextTheme(),
        tabBarTheme: const TabBarTheme(indicator: BoxDecoration(border: Border())),
      ),
      home: const MainScreen(),
    );
  }
}
