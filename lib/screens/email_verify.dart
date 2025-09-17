import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerifyScreen extends StatefulWidget {
  final User user;
  const EmailVerifyScreen({required this.user, super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  bool isVerified = false;

  Future<void> _checkVerified() async {
    await widget.user.reload();
    final refreshed = FirebaseAuth.instance.currentUser!;
    setState(() => isVerified = refreshed.emailVerified);
  }

  @override
  Widget build(BuildContext context) {
    if (isVerified) {
      // StreamBuilder will pick this up and rebuild Root -> HomeScreen
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Please verify your email."),
            ElevatedButton(
              onPressed: () async {
                await widget.user.sendEmailVerification();
              },
              child: const Text("Resend verification email"),
            ),
            ElevatedButton(
              onPressed: _checkVerified,
              child: const Text("I have verified"),
            ),
          ],
        ),
      ),
    );
  }
}
