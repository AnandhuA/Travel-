import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Widgets/trip_details_screen_widgets.dart';
import 'package:travel/colors.dart';

class TripDetailsScreen extends StatefulWidget {
  final int index;

  const TripDetailsScreen({super.key, required this.index});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TripModel trip = tripList.value[widget.index];
    List<DateTime> days = getDaysInRange(trip.rangeStart, trip.rangeEnd);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: size.height * 0.15,
              decoration: BoxDecoration(
                color: blue50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircularPercentIndicator(
                    radius: 60,
                    lineWidth: 15,
                    backgroundColor: blue100,
                    progressColor: blue,
                    percent: 0.6,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your Budget",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "₹ 10,000",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < days.length; i++)
                    tabContainer(
                        context: context,
                        day: "Day ${i + 1}",
                        index: i,
                        date: days[i]),
                ],
              ),
            ),
            Text(
              days[selectedTab].toString(),
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
            selectedTab = index;
          });
        },
        child: animatedContainerWidget(
          selectedTab: selectedTab,
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
