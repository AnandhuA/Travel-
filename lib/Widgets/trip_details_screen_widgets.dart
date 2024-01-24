import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel/colors.dart';

Widget animatedContainerWidget(
    {required selectedTab, required index, required BuildContext context,required day ,required date,}) {
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
                style: const TextStyle(
                  color: white,
                ),
              ),
              Text(
                DateFormat('dd MMM').format(date),
                style: const TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
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
