import 'package:flutter/material.dart';
import 'onboarding_1.dart';
import 'onboarding_2.dart';
import 'onboarding_3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    OnboardingScreen1(),
    OnboardingScreen2(),
    OnboardingScreen3(),
  ];

  @override
  Widget build(BuildContext context) {
    var buttonText = Text(
      'Next →',
      style: Theme.of(
        context,
      ).textTheme.bodyMedium!.copyWith(color: Colors.white),
    );
    if (_currentPage == 1) {
      buttonText = Text(
        'Keep Going →',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Colors.white),
      );
    }
    if (_currentPage == 2) {
      buttonText = Text(
        'Get Started',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Colors.white),
      );
    }
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) => setState(() => _currentPage = index),
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, bottom: 40),
        child: Container(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (_currentPage < _pages.length - 1) {
                _controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              } else {
                // Go to auth or home screen
              }
            },
            child: buttonText,
          ),
        ),
      ),
    );
  }
}
