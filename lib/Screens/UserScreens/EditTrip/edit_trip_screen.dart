// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Screens/UserScreens/EditTrip/edit_travel_companions.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/table_calendar.dart';
import 'package:travel/Widgets/text_field_widet.dart';
import 'package:travel/Widgets/time_picker.dart';
import 'package:travel/Styles/colors.dart';

DateTime? editedRangeStart;
DateTime? editedRangeEnd;
String editedTime = "";
String? editedDestination;
String? editedDescription;

class EditTripScreen extends StatefulWidget {
  TripModel editTrip;
  bool onGoing;
  EditTripScreen({super.key, required this.editTrip, required this.onGoing});

  @override
  State<EditTripScreen> createState() => _EditTripScreenState();
}

class _EditTripScreenState extends State<EditTripScreen> {
  TextEditingController destinationCntroller = TextEditingController();

  TextEditingController descriptionCntroller = TextEditingController();
  @override
  void initState() {
    descriptionCntroller.text = widget.editTrip.description;
    destinationCntroller.text = widget.editTrip.destination;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Trip"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CalenderView(
              rangestart: widget.editTrip.rangeStart,
              rangeend: widget.editTrip.rangeEnd,
              onGoing: widget.onGoing,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  TimePickerWidegt(
                    time: widget.editTrip.time,
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  addButton(
                    add: "Next",
                    color: blue400,
                    onpress: () {
                      final rangeStart = getTableCalendarRangeStart();
                      final rangeEnd = getTableCalendarRangeEnd();
                      final time = getSelectedTime();
                      if (descriptionCntroller.text.isNotEmpty &&
                          destinationCntroller.text.isNotEmpty &&
                          time.isNotEmpty &&
                          rangeStart != null &&
                          rangeEnd != null) {
                        editedDescription = descriptionCntroller.text;
                        editedDestination = destinationCntroller.text;
                        editedRangeStart = rangeStart;
                        editedRangeEnd = rangeEnd;
                        editedTime = time;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditCompanionsScreen(
                                  editTrip: widget.editTrip),
                            ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Select all feilds"),
                          backgroundColor: red,
                        ));
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
