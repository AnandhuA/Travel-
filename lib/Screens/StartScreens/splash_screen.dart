import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/colors.dart';
import 'package:travel/main.dart';

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

  void goToAdminHome() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "AdminHomePage");
    });
  }

  void checkLogin() async {
    // final sharedpre = await SharedPreferences.getInstance();
    // final userLoin = sharedpre.getBool("KEY");
    final firebaseAuth = FirebaseAuth.instance;

    if (firebaseAuth.currentUser == null) {
      goTOLogin();
    } else if (firebaseAuth.currentUser!.email == "anandhu1407@gmail.com") {
      admin = true;

      goToAdminHome();
    } else {
      admin = false;
      goToHome();
    }
    // if (userLoin == null || userLoin == false) {
    //   goTOLogin();
    // } else {
    //   goToHome();
    // }
  }
}
