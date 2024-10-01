import 'package:flutter/material.dart';
import 'styling_page.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: CustomBackground(
        child: Form(
          key: _formKey, // Using Form to validate inputs
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'SIGN UP',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'First Name',
                controller: _firstNameController,
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Last Name',
                controller: _lastNameController,
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Email',
                controller: _emailController,
                icon: Icons.email,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Password TextField with validation
              CustomTextField(
                labelText: 'Password',
                controller: _passwordController,
                icon: Icons.lock,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Confirm Password TextField with matching logic
              CustomTextField(
                labelText: 'Confirm Password',
                controller: _confirmPasswordController,
                icon: Icons.lock,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Sign up button
              CustomButton(
                text: 'SIGN UP',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If form is valid, proceed with signup
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signing Up...')),
                    );
                    // Additional signup logic here
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
