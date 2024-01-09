import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
          decoration: const BoxDecoration(gradient: backgroundGradient),
          child: Center(
            child: Image.asset(
              "Assets/Images/logo.png",
              width: 100,
            ),
          ),
        ),
      ),
    );
  }

  void goTOLogin() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "Login");
    });
  }

  void goToHome() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "HomePage");
    });
  }

  void checkLogin() async {
    final sharedpre = await SharedPreferences.getInstance();
    final userLoin = sharedpre.getBool("KEY");
    if (userLoin == null || userLoin == false) {
      goTOLogin();
    } else {
      goToHome();
    }
  }
}
