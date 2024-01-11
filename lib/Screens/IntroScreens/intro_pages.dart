// ignore_for_file: prefer_const_constructors_in_immutables, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel/Screens/IntroScreens/intro_screen1.dart';
import 'package:travel/Screens/IntroScreens/intro_screen2.dart';
import 'package:travel/Screens/IntroScreens/intro_screens3.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _controller = PageController();
  bool lastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                lastPage = (value == 2);
              });
            },
            children: [
              const IntroScreen1(),
              const IntroScreen2(),
              const IntroScreen3()
            ],
          ),
          Container(
            alignment: const Alignment(0.7, -0.7),
            child: InkWell(
              onTap: () {
                _controller.jumpToPage(2);
              },
              child: lastPage
                  ? const SizedBox()
                  : const Text(
                      "Skip",
                      style: TextStyle(fontSize: 20),
                    ),
            ),
          ),
          Container(
            alignment: const Alignment(-0.5, 0.44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmoothPageIndicator(
                    effect: const ExpandingDotsEffect(
                      expansionFactor: 2,
                      radius: 1,
                      strokeWidth: 1,
                      dotHeight: 4,
                      activeDotColor: Colors.orange,
                    ),
                    controller: _controller,
                    count: 3),
                lastPage
                    ? InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "HomePage");
                        },
                        child: const Text(
                          "Done",
                          style: TextStyle(fontSize: 20),
                        ))
                    : InkWell(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate);
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(fontSize: 20),
                        ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
