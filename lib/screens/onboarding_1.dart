import 'package:flutter/material.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          children: [
            Text('Chatily'),
            Image.asset('assets/images/conversation.png'),
            Text('Stay connected, anytime.'),
            Text(
              'Chatily lets you message friends and groups instantly, no matter where they are.',
            ),
          ],
        ),
      ),
    );
  }
}
