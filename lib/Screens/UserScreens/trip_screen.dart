import 'package:flutter/material.dart';
import 'package:travel/Screens/UserScreens/completed_screen.dart';
import 'package:travel/Screens/UserScreens/upcoming_screen.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/colors.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  bool button = true;
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        // SizedBox(
        //   height: 20,
        // ),
        Container(
          color: white,
          padding: const EdgeInsets.only(bottom: 20, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              textButton(
                title: "Upcoming",
                color: button ? black : grey,
                fun: () {
                  setState(() {
                    button = true;
                  });
                },
              ),
              textButton(
                title: "Completed",
                color: button ? grey : black,
                fun: () {
                  setState(() {
                    button = false;
                  });
                },
              )
            ],
          ),
        ),
        button ? const UpcomingTrip() : const ComplectedTrip(),
      ],
    );
  }
}
