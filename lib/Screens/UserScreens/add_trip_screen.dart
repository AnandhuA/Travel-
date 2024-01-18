// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/table_calendar.dart';
import 'package:travel/Widgets/text_field_widet.dart';
import 'package:travel/Widgets/time_picker.dart';
import 'package:travel/animation.dart';

class AddTripScreen extends StatelessWidget {
  AddTripScreen({
    super.key,
  });
  TextEditingController destinationCntroller = TextEditingController();
  TextEditingController descriptionCntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CalenderView(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                textField(
                    controller: destinationCntroller,
                    label: "Destination",
                    icon: const Icon(Icons.location_on_outlined)),
                textField(
                    controller: descriptionCntroller,
                    label: "Description",
                    line: 3,
                    icon: const Icon(Icons.description_outlined)),
                const SizedBox(
                  height: 20,
                ),
                 TimePickerWidegt(),
                const SizedBox(
                  height: 30,
                ),
                addButton(
                    color: Colors.blue.shade400,
                    onpress: () async {
                      final rangeStart = getTableCalendarRangeStart();
                      final rangeEnd = getTableCalendarRangeEnd();
                      final time = getSelectedTime();

                      if (rangeStart != null &&
                          rangeEnd != null &&
                          descriptionCntroller.text.isNotEmpty &&
                          destinationCntroller.text.isNotEmpty &&
                          time.isNotEmpty) {
                        TripModel trip = TripModel(
                          id: DateTime.now().microsecondsSinceEpoch.toString(),
                          destination: destinationCntroller.text,
                          description: descriptionCntroller.text,
                          time: time,
                          rangeStart: rangeStart,
                          rangeEnd: rangeEnd,
                          uid: FirebaseAuth.instance.currentUser!.uid.toString()
                        );
                        animationAdded(context: context);
                        await addTrip(trip: trip);
                        descriptionCntroller.clear();
                        destinationCntroller.clear();
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Select all feilds"),
                          backgroundColor: Colors.red,
                        ));
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}