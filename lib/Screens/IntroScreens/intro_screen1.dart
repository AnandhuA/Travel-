import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travel/colors.dart';
import 'package:travel/style.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(children: [
          const SizedBox(
            height: 200,
          ),
          Lottie.asset(
            "Assets/Animations/animation walking.json",
            height: 150,
          ),
          const SizedBox(
            height: 50,
          ),
           Text(
            "Find Your Destination",
            style: introtextstyle2,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Life is an adventure.Let's make it an",
            style: TextStyle(color: grey),
          ),
          const Text(
            "unforgetable one",
            style: TextStyle(color: grey),
          ),
        ]),
      ),
    ));
  }
}
