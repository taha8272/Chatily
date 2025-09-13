import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                isLogin ? 'Welcome Back' : 'Get Started',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                isLogin
                    ? 'Login to get access'
                    : 'Create a new account to get started',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 40),
              Container(
                width: 400,
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
                      duration: Duration(microseconds: 300),
                      curve: Curves.easeInOut,
                      child: Container(
                        width: 200,
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 177, 211, 84),
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
                              child: Text(
                                'Email',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 70),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isEmail = false;
                              });
                            },

                            child: Center(
                              child: Text(
                                'Phone',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                    ),
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
                  children: [
                    // Toggle between Email and Phone
                    SizedBox(height: 24),
                    // Email or Phone Field
                    if (isEmail)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 16,
                                ),
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(
                                      255,
                                      58,
                                      56,
                                      56,
                                    ),
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(
                                      255,
                                      151,
                                      147,
                                      147,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (newValue) {
                                selectedEmail = newValue;
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !value.contains("@gmail.com")) {
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 16,
                                ),
                                hintText: 'Enter your Phone',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(
                                      255,
                                      58,
                                      56,
                                      56,
                                    ),
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(
                                      255,
                                      151,
                                      147,
                                      147,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              keyboardType: TextInputType.emailAddress,
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
                    SizedBox(height: 16),
                    // Password Field (for both login/signup)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 40,
                          child: TextFormField(
                            obscureText: true,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 16,
                              ),
                              hintText: 'Enter Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 58, 56, 56),
                                  width: 0.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                    255,
                                    151,
                                    147,
                                    147,
                                  ),
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            keyboardType: TextInputType.emailAddress,
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
                      ],
                    ),
                    SizedBox(height: 24),
                    // Login/Signup Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Add authentication logic
                        },
                        child: Text(isLogin ? 'Login' : 'Sign Up'),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Toggle between Login and Signup
                    TextButton(
                      onPressed: () {
                        setState(() => isLogin = !isLogin);
                      },
                      child: Text(
                        isLogin
                            ? "Don't have an account? Sign Up"
                            : "Already have an account? Login",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
