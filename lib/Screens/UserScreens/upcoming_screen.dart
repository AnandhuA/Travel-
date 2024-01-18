import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Screens/UserScreens/edit_trip_screen.dart';
import 'package:travel/Screens/UserScreens/trip_details_page.dart';

class UpcomingTrip extends StatelessWidget {
  const UpcomingTrip({super.key});

  @override
  Widget build(BuildContext context) {
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
                            // SlidableAction(
                            //   backgroundColor: Colors.red.shade50,
                            //   autoClose: true,
                            //   onPressed: (contex) {
                            //     deleteTrip(trip: trip);
                            //   },
                            //   foregroundColor: Colors.red,
                            //   icon: Icons.delete,
                            //   label: "Delect",
                            // ),
                            SlidableAction(
                              backgroundColor: Colors.blue.shade100,
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
                              foregroundColor: Colors.blue,
                              icon: Icons.edit_note_sharp,
                              label: "Edit",
                            )
                          ]),
                      endActionPane: ActionPane(
                        extentRatio: 0.2,
                        motion: const StretchMotion(),
                        children: [
                          // SlidableAction(
                          //   backgroundColor: Colors.blue.shade100,
                          //   autoClose: true,
                          //   onPressed: (contex) {},
                          //   foregroundColor: Colors.blue,
                          //   icon: Icons.edit_note_sharp,
                          //   label: "Edit",
                          // ),
                          SlidableAction(
                            backgroundColor: Colors.red.shade50,
                            autoClose: true,
                            onPressed: (context) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text("Delete successfully"),
                                backgroundColor: Colors.black,
                              ));
                              deleteTrip(trip: trip);
                            },
                            foregroundColor: Colors.red,
                            icon: Icons.delete,
                            label: "Delect",
                          ),
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TripDetailsScreen(index: index),
                              ));
                        },
                        tileColor: tripNow
                            ? Colors.orange.shade50
                            : Colors.green.shade50,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: tripNow
                              ? Colors.orange.shade100
                              : Colors.green.shade100,
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
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                ),
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
                    return const SizedBox(
                      height: 2,
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
}