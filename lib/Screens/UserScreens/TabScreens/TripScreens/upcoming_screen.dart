import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Notifications/show_notification.dart';
import 'package:travel/Screens/UserScreens/EditTrip/edit_trip_screen.dart';
import 'package:travel/Screens/UserScreens/TabScreens/TripScreens/TripDetailsScreens/trip_details_page.dart';
import 'package:travel/Styles/colors.dart';

class UpcomingTrip extends StatelessWidget {
  const UpcomingTrip({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: tripList,
        builder: (context, value, child) {
          return tripList.value.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    TripModel trip = tripList.value[index];
                    DateTime now = DateTime.now();
                    String dateTrailing =
                        DateFormat('MMM yyyy').format(trip.rangeStart);
                    String day = DateFormat('dd').format(trip.rangeStart);
                    String week = DateFormat('EEE').format(trip.rangeStart);
                    String start =
                        DateFormat('dd MMM yyyy').format(trip.rangeStart);
                    String end =
                        DateFormat('dd MMM yyyy').format(trip.rangeEnd);
                    bool tripNow = false;
                    if (trip.rangeStart.isBefore(now) &&
                        trip.rangeEnd.isAfter(now)) {
                      tripNow = true;
                    }

                    return Slidable(
                      key: Key(trip.id),
                      startActionPane: ActionPane(
                          extentRatio: 0.2,
                          motion: const StretchMotion(),
                          children: [
                          
                            SlidableAction(
                              backgroundColor: blue100,
                              autoClose: true,
                              onPressed: (contex) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditTripScreen(
                                        editTrip: trip,
                                        onGoing: tripNow,
                                      ),
                                    ));
                              },
                              foregroundColor: blue,
                              icon: Icons.edit_note_sharp,
                              label: "Edit",
                            )
                          ]),
                      endActionPane: ActionPane(
                        extentRatio: 0.2,
                        motion: const StretchMotion(),
                        children: [
                  
                          SlidableAction(
                            backgroundColor: red50,
                            autoClose: true,
                            onPressed: (context) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text("Delete successfully"),
                                backgroundColor: black,
                              ));
                              deleteTrip(trip: trip);
                            },
                            foregroundColor: red,
                            icon: Icons.delete,
                            label: "Delect",
                          ),
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          String time = trip.time;
                          List<String> parts = time.split(":");
                          int hours = int.parse(parts[0]);
                          int minutes = int.parse(parts[1].split(" ")[0]);
                          String amPm = parts[1].split(" ")[1];

                          DateTime tripDateTime;

                          if (hours != 0) {
                            int adjustedHour =
                                amPm == "AM" ? hours % 12 : (hours % 12) + 12;
                            tripDateTime = DateTime(
                              trip.rangeStart.year,
                              trip.rangeStart.month,
                              trip.rangeStart.day,
                              adjustedHour,
                              minutes,
                            );
                          } else {
                            tripDateTime = DateTime.now();
                          }
                          showNotification(
                            date: tripDateTime,
                            title: trip.destination,
                            body: trip.description,
                          );

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TripDetailsScreen(index: index),
                              ));
                        },
                        tileColor: tripNow ? orange50 : green50,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.017,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: tripNow ? orange100 : green100,
                          radius: 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(),
                              Text(
                                day,
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                week,
                                style: TextStyle(color: grey800),
                              )
                            ],
                          ),
                        ),
                        title: Text(
                          trip.destination,
                          style: const TextStyle(fontSize: 20),
                        ),
                        subtitle: tripNow ? Text("$start to $end") : null,
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              trip.time,
                              style: const TextStyle(fontSize: 13),
                            ),
                            Text(
                              dateTrailing,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: screenHeight * 0.005,
                    );
                  },
                  itemCount: tripList.value.length,
                )
              : const Center(
                  child: Text("No trip"),
                );
        },
      ),
    );
  }

  DateTime parseTimeString(String timeString) {
    try {
      // Convert the timeString to a DateTime object
      return DateTime.parse("1970-01-01 $timeString");
    } catch (e) {
      
      return DateTime.now();
    }
  }
}
