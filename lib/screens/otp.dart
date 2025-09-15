import 'package:chatily/screens/onboarding/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.verificationId});
  final String verificationId;
  @override
  State<OTPScreen> createState() {
    return _OTPScreenState();
  }
}

class _OTPScreenState extends State<OTPScreen> {
  var otpController = TextEditingController();
  void verifyPhoneNumber() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text.toString(),
      );
      FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        return Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => OnboardingScreen()));
      });
    } catch (ex) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: otpController,
              decoration: InputDecoration(label: Text('Enter OTP')),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                verifyPhoneNumber();
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
