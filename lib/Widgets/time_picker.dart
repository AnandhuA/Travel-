// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:travel/Styles/colors.dart';

class TimePickerWidegt extends StatefulWidget {
  String? time;
  bool? onGoing;
  TimePickerWidegt({super.key, this.time, this.onGoing});

  @override
  State<TimePickerWidegt> createState() => _TimePickerWidegtState();
}

int hour = 0;
int min = 0;
String timeformat = "AM";

class _TimePickerWidegtState extends State<TimePickerWidegt> {
  @override
  void initState() {
    super.initState();
    if (widget.time != null) {
      String? time = widget.time;

      List<String> parts = time!.split(":");

      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1].split(" ")[0]);
      String amPm = parts[1].split(" ")[1];

      hour = hours;
      min = minutes;
      timeformat = amPm;
    }
  }

  @override
  void dispose() {
    hour = 0;
    min = 0;
    timeformat = "AM";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text(
          "Pick your time ${hour.toString().padLeft(2, '0')} : ${min.toString().padLeft(2, '0')} $timeformat",
          style: const TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          width: double.infinity,
          decoration: BoxDecoration(
            color: blue50,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NumberPicker(
                haptics: true,
                infiniteLoop: true,
                textStyle: const TextStyle(color: black45),
                selectedTextStyle: TextStyle(color: blue300, fontSize: 30),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: black45),
                    bottom: BorderSide(color: black45),
                  ),
                ),
                minValue: 0,
                maxValue: 12,
                zeroPad: true,
                itemWidth: 80,
                itemHeight: 40,
                value: hour,
                onChanged: (value) {
                  setState(() {
                    hour = value;
                  });
                },
              ),
              NumberPicker(
                haptics: true,
                infiniteLoop: true,
                textStyle: const TextStyle(color: black45),
                selectedTextStyle: TextStyle(color: blue300, fontSize: 30),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: black45),
                    bottom: BorderSide(color: black45),
                  ),
                ),
                minValue: 0,
                maxValue: 59,
                zeroPad: true,
                itemWidth: 80,
                itemHeight: 40,
                value: min,
                onChanged: (value) {
                  setState(() {
                    min = value;
                  });
                },
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        timeformat = "AM";
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 60,
                      decoration: timeformat == "AM"
                          ? BoxDecoration(
                              color: bluetime,
                              border: Border.all(color: blue),
                              borderRadius: BorderRadius.circular(10),
                            )
                          : const BoxDecoration(),
                      child: const Center(child: Text("AM")),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        timeformat = "PM";
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 60,
                      decoration: timeformat == "PM"
                          ? BoxDecoration(
                              color: bluetime,
                              border: Border.all(color: blue),
                              borderRadius: BorderRadius.circular(10),
                            )
                          : const BoxDecoration(),
                      child: const Center(child: Text("PM")),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

String getSelectedTime() {
  if (hour != 0) {
    return "${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')} $timeformat";
  } else {
    return "";
  }
}
