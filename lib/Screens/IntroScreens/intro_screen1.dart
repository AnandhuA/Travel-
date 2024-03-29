import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travel/Styles/colors.dart';
import 'package:travel/Styles/text_style.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(children: [
          SizedBox(
            height: size.height * 0.18,
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
