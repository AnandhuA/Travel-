import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void animationSignup({required context}) {
  showDialog(
    context: context,
    builder: (context) {
      return Container(
        child: Lottie.asset(
          "Assets/Animations/tick.json",
        ),
      );
    },
  );
  Timer(const Duration(seconds: 1), () {
    Navigator.pushReplacementNamed(context, "Login");
  });
}

void animationAdded({required context}) {
  showDialog(
    context: context,
    builder: (context) {
      return Container(
        child: Lottie.asset(
          "Assets/Animations/tick2.json",
        ),
      );
    },
  );
  Timer(const Duration(seconds: 2), () {
    Navigator.pop(context);
  });
}
