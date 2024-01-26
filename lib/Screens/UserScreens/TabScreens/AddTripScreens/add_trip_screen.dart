// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/table_calendar.dart';
import 'package:travel/Widgets/text_field_widet.dart';
import 'package:travel/Widgets/time_picker.dart';
import 'package:travel/Styles/colors.dart';

DateTime? selectedRangeStart;
DateTime? selectedRangeEnd;
String selectedTime = "";
String? destination;
String? description;

class AddTripScreen extends StatelessWidget {
  AddTripScreen({
    super.key,
  });
  final TextEditingController _destinationCntroller = TextEditingController();
  final TextEditingController _descriptionCntroller = TextEditingController();
  // final CalenderView calenderView = CalenderView();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CalenderView(),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              children: [
                textField(
                    controller: _destinationCntroller,
                    label: "Destination",
                    icon: const Icon(Icons.location_on_outlined)),
                textField(
                    controller: _descriptionCntroller,
                    label: "Description",
                    line: 3,
                    icon: const Icon(Icons.description_outlined)),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                TimePickerWidegt(),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                addButton(
                    add: "Next",
                    color: blue400,
                    onpress: () async {
                      selectedRangeStart = getTableCalendarRangeStart();
                      selectedRangeEnd = getTableCalendarRangeEnd();

                      selectedTime = getSelectedTime();
                      if (selectedRangeStart != null &&
                          selectedRangeEnd != null &&
                          selectedTime.isNotEmpty &&
                          _descriptionCntroller.text.isNotEmpty &&
                          _destinationCntroller.text.isNotEmpty) {
                        description = _descriptionCntroller.text;
                        destination = _destinationCntroller.text;
                        Navigator.pushNamed(context, "AddCompanions");
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Select all feilds......"),
                          backgroundColor: red,
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
