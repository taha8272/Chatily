import 'package:chatily/screens/auth.dart';
import 'package:chatily/screens/email_verify.dart';
import 'package:chatily/screens/home.dart';
import 'package:chatily/screens/onboarding/onboarding.dart';
import 'package:chatily/screens/onboarding/onboarding_1.dart';
import 'package:chatily/screens/onboarding/onboarding_2.dart';
import 'package:chatily/screens/onboarding/onboarding_3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          background: Color(0xFFF5F7FB),
          onBackground: Colors.black87,
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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 96, 43, 194), // primary
            foregroundColor: Colors.white, // onPrimary
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900, // Extra bold
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black87,
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
          background: Color(0xFF181A20),
          onBackground: Colors.white,
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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey[900], // primary
            foregroundColor: Colors.white, // onPrimary
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF23272F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900, // Extra bold
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
      themeMode: ThemeMode.system, // Uses system setting (light/dark)
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data;
          if (user == null) {
            return AuthScreen(); // your login/register screen
          }

          final providerIds = user.providerData
              .map((p) => p.providerId)
              .toList();
          final isEmail = providerIds.contains('password');

          if (isEmail && !user.emailVerified) {
            return EmailVerifyScreen(user: user);
          }

          return OnboardingScreen();
        },
      ),
    );
  }
}
