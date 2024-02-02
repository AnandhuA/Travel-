import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travel/Styles/colors.dart';
import 'package:travel/Styles/text_style.dart';

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.18,
              ),
              Lottie.asset(
                "Assets/Animations/explore.json",
                height: 150,
              ),
              const SizedBox(
                height: 40,
              ),
              Text("Explore Destinations", style: introtextstyle2),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Discover the places for your trip in the",
                style: TextStyle(color: grey),
              ),
              const Text(
                "World and feed great.",
                style: TextStyle(color: grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
