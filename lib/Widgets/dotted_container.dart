import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:travel/Styles/colors.dart';

Widget dottedContainer(
    {required String text,
    required double height,
    required double width,
    required IconData icon}) {
  return DottedBorder(
    borderType: BorderType.RRect,
    dashPattern: const [8, 4],
    radius: const Radius.circular(20),
    child: SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: grey700,
            ),
            Text(text)
          ],
        ),
      ),
    ),
  );
}
