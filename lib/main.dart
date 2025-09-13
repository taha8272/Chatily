import 'package:chatily/screens/onboarding_1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.blueAccent,
          onPrimary: Colors.white,
          secondary: Colors.teal,
          onSecondary: Colors.white,

          surface: Colors.white,
          onSurface: Colors.black87,
          error: Colors.redAccent,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: Color(0xFFF5F7FB),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.blueGrey[900]!,
          onPrimary: Colors.white,
          secondary: Colors.tealAccent[200]!,
          onSecondary: Colors.black,

          surface: Color(0xFF23272F),
          onSurface: Colors.white,
          error: Colors.red[400]!,
          onError: Colors.black,
        ),
        scaffoldBackgroundColor: Color(0xFF181A20),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[900],
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.tealAccent[200],
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF23272F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      themeMode: ThemeMode.system, // Uses system setting (light/dark)
      home: OnboardingScreen1(),
    );
  }
}
