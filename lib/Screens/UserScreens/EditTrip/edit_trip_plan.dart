// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Screens/UserScreens/EditTrip/edit_travel_companions.dart';
import 'package:travel/Screens/UserScreens/EditTrip/edit_trip_screen.dart';
import 'package:travel/Styles/colors.dart';
import 'package:travel/Widgets/time_line_widget.dart';
import 'package:travel/Widgets/trip_details_screen_widgets.dart';

class EditTripPlan extends StatefulWidget {
  TripModel editTrip;
  EditTripPlan({super.key, required this.editTrip});

  @override
  State<EditTripPlan> createState() => _EditTripPlanState();
}

Map<String, List<String>> _stringMap = {};

class _EditTripPlanState extends State<EditTripPlan> {
  int _selectedTab = 0;
  final TextEditingController _addPlanController = TextEditingController();
  List<DateTime> _days = [];
  @override
  void initState() {
    super.initState();
    _stringMap = widget.editTrip.activitys;
    _days =
        getDaysInRange(widget.editTrip.rangeStart, widget.editTrip.rangeEnd);
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
            onPressed: () async {
              if (editedDestination != null &&
                  editedDescription != null &&
                  editedRangeStart != null &&
                  editedRangeEnd != null &&
                  editedTravelType != null &&
                  editedNumberOfPeople != null &&
                  editedBudget != null) {
                TripModel trip = TripModel(
                  id: widget.editTrip.id,
                  destination: editedDestination!,
                  description: editedDescription!,
                  time: editedTime,
                  rangeStart: editedRangeStart!,
                  rangeEnd: editedRangeEnd!,
                  uid: FirebaseAuth.instance.currentUser!.uid.toString(),
                  travelType: editedTravelType!,
                  numberOfPeople: editedNumberOfPeople!,
                  budget: editedBudget!,
                  activitys: _stringMap,
                  notification: widget.editTrip.notification,
                );
                await addTrip(trip: trip);
              }
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
