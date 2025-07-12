import 'package:flutter/material.dart';
import 'package:todo_app/screens/cart_screen.dart';
import 'package:todo_app/screens/dashboard_screen.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}
