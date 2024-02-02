import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel/Screens/IntroScreens/intro_screen1.dart';
import 'package:travel/Screens/IntroScreens/intro_screen2.dart';
import 'package:travel/Screens/IntroScreens/intro_screens3.dart';
import 'package:travel/Styles/colors.dart';
import 'package:travel/Styles/text_style.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController controller = PageController();
  bool lastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                lastPage = (value == 2);
              });
            },
            children: const [IntroScreen1(), IntroScreen2(), IntroScreen3()],
          ),
          Container(
            alignment: const Alignment(0.7, -0.7),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, "HomePage");
              },
              child: lastPage
                  ? const SizedBox()
                  : Text(
                      "Skip",
                      style: introtextstyle1,
                    ),
            ),
          ),
          Container(
            alignment: const Alignment(0, 0.44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmoothPageIndicator(
                    effect: const ExpandingDotsEffect(
                      expansionFactor: 2,
                      radius: 1,
                      strokeWidth: 1,
                      dotHeight: 4,
                      activeDotColor: orange,
                    ),
                    controller: controller,
                    count: 3),
                lastPage
                    ? InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "HomePage");
                        },
                        child: Text(
                          "Done",
                          style: introtextstyle1,
                        ))
                    : InkWell(
                        onTap: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate);
                        },
                        child: Text(
                          "Next",
                          style: introtextstyle1,
                        ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
