import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              Lottie.asset(
                "Assets/Animations/explore.json",
                height: 150,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Explore Destinations",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Discover the places for your trip in the",
                style: TextStyle(color: Colors.grey),
              ),
              const Text(
                "World and feed great.",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
