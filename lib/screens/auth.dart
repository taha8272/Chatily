import 'package:chatily/screens/otp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true; // Toggle between login and signup
  bool isEmail = true; // Toggle between email and phone

  final _formKey = GlobalKey<FormState>();
  var selectedEmail;
  var selectedPassword;
  var selectedPhone;
  var firstName;
  var lastName;

  void onSaved() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    if (isLogin) {
      if (isEmail) {
        try {
          final credentials = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                email: selectedEmail,
                password: selectedPassword,
              );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          }
        }
      } else {}
    } else if (!isLogin) {
      if (isEmail) {
        try {
          final credentials = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: selectedEmail,
                password: selectedPassword,
              );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        }
      } else {
        await FirebaseAuth.instance.verifyPhoneNumber(
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException ex) {},
          codeSent: (verificationId, forceResendingToken) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OTPScreen(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {},
          phoneNumber: selectedPhone,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D5DF6), Color(0xFF3D3A62)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Logo or illustration
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Image.asset('assets/images/logo.png', height: 200),
                  ),

                  // Card for the form
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text(
                            isLogin ? 'Welcome Back' : 'Get Started',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isLogin
                                ? 'Login to get access'
                                : 'Create a new account to get started',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 32),
                          // Modern toggle
                          Container(
                            width: 320,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 231, 229, 229),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Stack(
                              children: [
                                AnimatedAlign(
                                  alignment: isEmail
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6D5DF6),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isEmail = true;
                                          });
                                        },
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.email,
                                                color: isEmail
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                'Email',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontWeight: isEmail
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                      fontSize: 18,
                                                      color: isEmail
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isEmail = false;
                                          });
                                        },
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                color: !isEmail
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                'Phone',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontWeight: !isEmail
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                      fontSize: 18,
                                                      color: !isEmail
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 24),
                                // Email or Phone Field
                                if (!isLogin) ...[
                                  Text(
                                    'First Name',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      cursorColor: Colors.deepPurple,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your first name',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF6D5DF6),
                                            width: 1.5,
                                          ),
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      onSaved: (value) => firstName = value,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your first name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Last Name',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      cursorColor: Colors.deepPurple,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your last name',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF6D5DF6),
                                            width: 1.5,
                                          ),
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      onSaved: (value) => lastName = value,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your last name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                                if (isEmail)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 48,
                                        child: TextFormField(
                                          cursorColor: Colors.deepPurple,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  vertical: 14,
                                                  horizontal: 16,
                                                ),
                                            hintText: 'Enter your email',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 0.5,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                color: Color(0xFF6D5DF6),
                                                width: 1.5,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 0.5,
                                              ),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          onSaved: (newValue) {
                                            selectedEmail = newValue;
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                !value.contains("@")) {
                                              return 'Enter a valid email address';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Phone Number',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 48,
                                        child: TextFormField(
                                          cursorColor: Colors.deepPurple,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  vertical: 14,
                                                  horizontal: 16,
                                                ),
                                            hintText: 'Enter your phone',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 0.5,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                color: Color(0xFF6D5DF6),
                                                width: 1.5,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 0.5,
                                              ),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          keyboardType: TextInputType.phone,
                                          onSaved: (newValue) {
                                            selectedPhone = newValue;
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                value.length < 9) {
                                              return 'Enter a valid phone number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 16),
                                // Password Field
                                Text(
                                  'Password',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 48,
                                  child: TextFormField(
                                    obscureText: true,
                                    cursorColor: Colors.deepPurple,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 14,
                                            horizontal: 16,
                                          ),
                                      hintText: 'Enter password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF6D5DF6),
                                          width: 1.5,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    onSaved: (newValue) {
                                      selectedPassword = newValue;
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length < 6) {
                                        return 'Enter a valid password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 24),
                                // Login/Signup Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF6D5DF6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      elevation: 4,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                    ),
                                    onPressed: () {
                                      onSaved();
                                    },
                                    child: Text(
                                      isLogin ? 'Login' : 'Sign Up',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Toggle between Login and Signup
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() => isLogin = !isLogin);
                                    },
                                    child: Text(
                                      isLogin
                                          ? "Don't have an account? Sign Up"
                                          : "Already have an account? Login",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
