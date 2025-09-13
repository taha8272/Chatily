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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 40),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 242, 242),
                  borderRadius: BorderRadius.circular(18),
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
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30),
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

                            child: Center(child: Text('Email')),
                          ),
                        ),
                        const SizedBox(width: 50),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isEmail = false;
                              });
                            },

                            child: Center(child: Text('Phone')),
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
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                      )
                    else
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: 'Phone Number'),
                        keyboardType: TextInputType.phone,
                      ),
                    SizedBox(height: 16),
                    // Password Field (for both login/signup)
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
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
