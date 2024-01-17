// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Pick your time ${hour.toString().padLeft(2, '0')} : ${min.toString().padLeft(2, '0')} $timeformat",
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NumberPicker(
                haptics: true,
                infiniteLoop: true,
                textStyle: const TextStyle(color: Colors.black45),
                selectedTextStyle:
                    TextStyle(color: Colors.blue.shade300, fontSize: 30),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black45),
                    bottom: BorderSide(color: Colors.black45),
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
                textStyle: const TextStyle(color: Colors.black45),
                selectedTextStyle:
                    TextStyle(color: Colors.blue.shade300, fontSize: 30),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black45),
                    bottom: BorderSide(color: Colors.black45),
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
                              color: const Color.fromARGB(81, 33, 149, 243),
                              border: Border.all(color: Colors.blue),
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
                              color: const Color.fromARGB(81, 33, 149, 243),
                              border: Border.all(color: Colors.blue),
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
