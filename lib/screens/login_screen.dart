import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_button.dart';
import 'package:todo_app/widgets/custom_text.dart';
import 'package:todo_app/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showError('All fields are required');
      return;
    } else {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
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
              const CustomText(
                title: 'Welcome Back',
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
              const SizedBox(height: 8),
              CustomText(
                title: 'Login to continue',
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: emailController,
                label: 'Email Address',
                icon: Icons.email,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: passwordController,
                label: 'Password',
                obscureText: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 24),
              CustomButton(label: 'Login', onPressed: handleLogin),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                child: CustomText(
                  title: "Don't have an account? Sign up",
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
