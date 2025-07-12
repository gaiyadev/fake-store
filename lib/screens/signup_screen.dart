import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_button.dart';
import 'package:todo_app/widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final otherNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  void handleSignup() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showError('All fields except other name are required');
      return;
    }

    // Simulate successful signup
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created successfully!')),
    );

    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create Account',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: firstNameController,
                label: 'First Name',
                icon: Icons.person,
              ),
              const SizedBox(height : 12),
              CustomTextField(
                controller: lastNameController,
                label: 'Last Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: otherNameController,
                label: 'Other Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: emailController,
                label: 'Email Address',
                icon: Icons.email,
              ),
              const SizedBox(height: 12),

              CustomTextField(
                controller: phoneController,
                label: 'Phone Number',
                icon: Icons.phone,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: passwordController,
                label: 'Password',
                obscureText: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 24),

              CustomButton(label: 'Sign Up', onPressed: handleSignup),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
