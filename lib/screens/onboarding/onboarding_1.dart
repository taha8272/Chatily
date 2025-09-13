import 'package:flutter/material.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Chatily',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontSize: 35),
                ),
                Image.asset(
                  'assets/images/conversation.png',
                  height: screenheight * 0.55,
                  fit: BoxFit.contain,
                ),
                Text(
                  'Stay connected, anytime.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Chatily lets you message friends and groups instantly, no matter where they are.',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
