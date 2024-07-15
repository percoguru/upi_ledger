import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/auth/auth_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const routeName = '/signup';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
                validator: (value) {
                  // if (value.isEmpty) {
                  //   return 'Please enter your name.';
                  // }
                  // return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) {
                  // if (value.isEmpty || !value.contains('@')) {
                  //   return 'Please enter a valid email address.';
                  // }
                  // return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                validator: (value) {
                  // if (value.isEmpty || value.length < 6) {
                  //   return 'Password must be at least 6 characters long.';
                  // }
                  // return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Confirm Password',
                ),
                validator: (value) {
                  // if (value.isEmpty || value != _passwordController.text) {
                  //   return 'Passwords do not match.';
                  // }
                  // return null;
                },
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // if (_formKey.currentState.validate()) {
                  //   // Perform sign-up logic here
                  //   print('Name: ${_nameController.text}');
                  //   print('Email: ${_emailController.text}');
                  //   print('Password: ${_passwordController.text}');
                  // }
                  _authController.signUp(
                      _emailController.text, _passwordController.text);
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
