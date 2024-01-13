import 'package:flutter/material.dart';
import 'package:travel/Screens/UserScreens/completed_screen.dart';
import 'package:travel/Screens/UserScreens/upcoming_screen.dart';
import 'package:travel/Widgets/button.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  bool button = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              textButton(
                title: "Upcoming",
                color: button ? Colors.black : Colors.grey,
                fun: () {
                  setState(() {
                    button = true;
                  });
                },
              ),
              textButton(
                title: "Completed",
                color: button ? Colors.grey : Colors.black,
                fun: () {
                  setState(() {
                    button = false;
                  });
                },
              )
            ],
          ),
          button ? const UpcomingTrip() : const ComplectedTrip()
        ],
      ),
    );
  }
}
