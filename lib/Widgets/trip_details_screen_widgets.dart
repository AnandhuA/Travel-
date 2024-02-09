import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:travel/Styles/colors.dart';

Widget animatedContainerWidget({
  required selectedTab,
  required index,
  required BuildContext context,
  required day,
  required date,
}) {
  final size = MediaQuery.of(context).size;
  return AnimatedContainer(
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeOut,
    width: selectedTab == index ? size.width * 0.25 : size.width * 0.15,
    height: size.height * 0.05,
    decoration: BoxDecoration(
      color: selectedTab == index ? blue : blue50,
      borderRadius: BorderRadius.circular(10),
    ),
    child: selectedTab == index
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day,
                style: TextStyle(
                  color: white,
                  fontSize: size.height * 0.015,
                ),
              ),
              Text(
                DateFormat('dd MMM').format(date),
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.02,
                ),
              )
            ],
          )
        : Center(
            child: Text(
              day,
              style: const TextStyle(
                color: black,
              ),
            ),
          ),
  );
}

Widget durationWedget({
  required Duration duration,
  required bool countUp,
  required TimeUnit time,
  required String text,
  required BuildContext context,
}) {
  final size = MediaQuery.of(context).size;
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: blue50,
      borderRadius: BorderRadius.circular(20),
    ),
    width: size.height * 0.1,
    height: size.height * 0.13,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RawDigitItem(
              duration: duration,
              timeUnit: time,
              digitType: DigitType.first,
              countUp: countUp,
              style: TextStyle(fontSize: 38, color: grey700),
            ),
            RawDigitItem(
              duration: duration,
              timeUnit: time,
              digitType: DigitType.second,
              countUp: countUp,
              style: TextStyle(fontSize: 38, color: grey700),
            ),
          ],
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 11),
        )
      ],
    ),
  );
}

Widget listContainer({
  required Function() ontap,
  required BuildContext context,
  required String text,
  required IconData icon,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(15),
    onTap: ontap,
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: blue50,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 35,
            color: blue,
          ),
          Text(text)
        ],
      ),
    ),
  );
}
