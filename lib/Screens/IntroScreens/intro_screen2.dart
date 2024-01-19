import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travel/colors.dart';
import 'package:travel/style.dart';

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
             Text(
              "Plan a Trip",
              style: introtextstyle2,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Lets Wander where the WI-Fi is weak",
              style: TextStyle(color: grey),
            ),
            const Text(
              "and the adventure are endless",
              style: TextStyle(color: grey),
            ),
          ],
        ),
      ),
    );
  }
}
