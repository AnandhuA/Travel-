import 'package:flutter/material.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/table_calendar.dart';
import 'package:travel/Widgets/text_field_widet.dart';
import 'package:travel/Widgets/time_picker.dart';

class AddTripScreen extends StatelessWidget {
  const AddTripScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CalenderView(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                textField(
                    label: "Destination",
                    icon: const Icon(Icons.location_on_outlined)),
                textField(
                    label: "Description",
                    line: 3,
                    icon: const Icon(Icons.description_outlined)),
                const SizedBox(
                  height: 20,
                ),
                const TimePickerWidegt(),
                const SizedBox(
                  height: 30,
                ),
                addButton(color: Colors.blue.shade400, onpress: () {})
              ],
            ),
          )
        ],
      ),
    );
  }
}
