import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      body: Center(
        child: SizedBox(
          width: 480,
          height: size.height * 0.45,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 42,
                child: Center(
                  child: Text(
                    'Point of Sales',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 16),
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            child: TextField(
                              controller: _userNameController,
                              decoration: InputDecoration(
                                label: Text('User Name/Email/Phone Number'),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            child: TextField(
                              obscureText: true,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                label: Text('Password'),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          TextButton(
                            onPressed: () {},
                            child: Text('Forgot Password?'),
                          ),
                          SizedBox(height: 16),
                          TextButton(
                            onPressed: () {},
                            child: Text('Register'),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            fixedSize: Size(double.infinity, 36),
                          ),
                          child: Text('Login'),
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
    );
  }
}
