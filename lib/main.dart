import 'package:flutter/material.dart';
import 'package:travel/Screens/home_page.dart';
import 'package:travel/Screens/login_screen.dart';
import 'package:travel/Screens/signup_screen.dart';
import 'package:travel/Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      
      routes: {
        "Login": (context) => const LoginScreen(),
        "Signup": (context) => const SignUpScreen(),
        "HomePage":(context) => const HomePage()
      },
    );
  }
}
