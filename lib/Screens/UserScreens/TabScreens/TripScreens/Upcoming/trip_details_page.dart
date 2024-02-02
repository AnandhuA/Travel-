import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Screens/UserScreens/TabScreens/TripScreens/Upcoming/add_transaction.dart';
import 'package:travel/Widgets/time_line_widget.dart';
import 'package:travel/Widgets/trip_details_screen_widgets.dart';
import 'package:travel/Styles/colors.dart';

class TripDetailsScreen extends StatefulWidget {
  final TripModel trip;

  const TripDetailsScreen({super.key, required this.trip});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TripModel trip = widget.trip;
    List<DateTime> days = getDaysInRange(trip.rangeStart, trip.rangeEnd);
    Map<String, List<String>> activitys = trip.activitys;
    return Scaffold(
      appBar: AppBar(
        title: Text(trip.destination),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        tooltip: "Add Transaction",
        backgroundColor: blue300,
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              height: size.height * 0.2,
              child: ListView.builder(
                itemCount:
                    activitys[activitys.keys.elementAt(_selectedTab)]?.length,
                itemBuilder: (context, index) {
                  List<String>? plans =
                      activitys[activitys.keys.elementAt(_selectedTab)];

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.02,
                    ),
                    child: TimeLineWidget(
                      start: index == 0 ? true : false,
                      end: (index + 1) ==
                              activitys[activitys.keys.elementAt(_selectedTab)]
                                  ?.length
                          ? true
                          : false,
                      title: plans![index],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: size.height * 0.01,
              ),
              height: size.height * 0.15,
              decoration: BoxDecoration(
                color: blue50,
                border: Border.all(color: blue400),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircularPercentIndicator(
                    radius: size.height * 0.06,
                    lineWidth: size.height * 0.015,
                    backgroundColor: blue100,
                    progressColor: blue,
                    percent: 0.6,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your Budget",
                        style: TextStyle(fontSize: size.height * 0.02),
                      ),
                      Text(
                        "₹ ${trip.budget.toString()}",
                        style: TextStyle(
                          fontSize: size.height * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
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
