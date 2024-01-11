import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Lottie.asset(
              "Assets/Animations/plane2.json",
              height: 150,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Plan a Trip",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Lets Wander where the WI-Fi is weak",
              style: TextStyle(color: Colors.grey),
            ),
            const Text(
              "and the adventure are endless",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
