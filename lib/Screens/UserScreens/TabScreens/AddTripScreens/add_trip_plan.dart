// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Notifications/show_notification.dart';
import 'package:travel/Screens/UserScreens/TabScreens/AddTripScreens/add_travel_companions.dart';
import 'package:travel/Screens/UserScreens/TabScreens/AddTripScreens/add_trip_screen.dart';
import 'package:travel/Screens/UserScreens/TabScreens/TripScreens/Upcoming/trip_details_page.dart';
import 'package:travel/Styles/colors.dart';
import 'package:travel/Widgets/time_line_widget.dart';
import 'package:travel/Widgets/trip_details_screen_widgets.dart';

class AddTripPlan extends StatefulWidget {
  const AddTripPlan({super.key});

  @override
  State<AddTripPlan> createState() => _AddTripPlanState();
}

Map<String, List<String>> _stringMap = {};

class _AddTripPlanState extends State<AddTripPlan> {
  int _selectedTab = 0;
  final TextEditingController _addPlanController = TextEditingController();
  final List<DateTime> _days =
      getDaysInRange(selectedRangeStart!, selectedRangeEnd!);

  @override
  void initState() {
    for (int i = 0; i < _days.length; i++) {
      String dayKey = "Day ${i + 1}";
      _stringMap[dayKey] = [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add trip plans"),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              iconColor: white,
              backgroundColor: blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              _buttonClick(context: context);
            },
            label: const Icon(Icons.navigate_next_outlined),
            icon: const Text(
              "Add",
              style: TextStyle(color: white),
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.height * 0.02,
          vertical: size.height * 0.02,
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < _days.length; i++)
                    tabContainer(
                        context: context,
                        day: "Day ${i + 1}",
                        index: i,
                        date: _days[i]),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            TextField(
              controller: _addPlanController,
              decoration: InputDecoration(
                labelText: "Add Day ${_selectedTab + 1} plan",
                labelStyle: const TextStyle(color: blue),
                suffixIcon: IconButton(
                  onPressed: () {
                    _addPlanController.text.isNotEmpty
                        ? setState(() {
                            _stringMap["Day ${_selectedTab + 1}"]
                                ?.add(_addPlanController.text);
                          })
                        : "";
                    _addPlanController.clear();
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:
                    _stringMap[_stringMap.keys.elementAt(_selectedTab)]?.length,
                itemBuilder: (context, index) {
                  List<String>? plans =
                      _stringMap[_stringMap.keys.elementAt(_selectedTab)];

                  return TimeLineWidget(
                    start: index == 0 ? true : false,
                    end: (index + 1) ==
                            _stringMap[_stringMap.keys.elementAt(_selectedTab)]
                                ?.length
                        ? true
                        : false,
                    title: plans![index],
                    remove: () {
                      setState(() {
                        _stringMap["Day ${_selectedTab + 1}"]
                            ?.remove(plans[index]);
                      });
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tabContainer({
    required BuildContext context,
    required String day,
    required int index,
    required DateTime date,
  }) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: animatedContainerWidget(
          selectedTab: _selectedTab,
          index: index,
          context: context,
          day: day,
          date: date,
        ),
      ),
    );
  }
}

_buttonClick({required BuildContext context}) async {
  if (destination != null &&
      description != null &&
      selectedRangeStart != null &&
      selectedRangeEnd != null &&
      travelType != null &&
      numberOfPeople != null &&
      budget != null) {
    TripModel trip = TripModel(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      destination: destination!,
      description: description!,
      time: selectedTime,
      rangeStart: selectedRangeStart!,
      rangeEnd: selectedRangeEnd!,
      uid: FirebaseAuth.instance.currentUser!.uid.toString(),
      travelType: travelType!,
      numberOfPeople: numberOfPeople!,
      budget: budget!,
      activitys: _stringMap,
      notification: true,
    );
    await addTrip(trip: trip);
    
    DateTime tripDateTime = convertDateTime(trip: trip);
    if (tripDateTime.isAfter(DateTime.now())) {
      showNotification(
          date: tripDateTime,
          title: trip.destination,
          body: trip.description,
          id: trip.id);
    }

    Navigator.pop(context);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TripDetailsScreen(trip: trip),
        ));
  }
}

List<DateTime> getDaysInRange(DateTime rangeStart, DateTime rangeEnd) {
  List<DateTime> daysInRange = [];
  DateTime currentDay = rangeStart;
  while (
      currentDay.isBefore(rangeEnd) || currentDay.isAtSameMomentAs(rangeEnd)) {
    daysInRange.add(currentDay);
    currentDay = currentDay.add(const Duration(days: 1));
  }
  return daysInRange;
}
