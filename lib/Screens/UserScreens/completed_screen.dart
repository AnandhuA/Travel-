import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Screens/UserScreens/trip_details_page.dart';

class ComplectedTrip extends StatelessWidget {
  const ComplectedTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: tripListCompleted,
        builder: (context, value, child) {
          return tripListCompleted.value.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    TripModel trip = tripListCompleted.value[index];
                    String dateTrailing =
                        DateFormat('MMM yyyy').format(trip.rangeStart);
                    String rangeEnd =
                        DateFormat('dd MMM yyyy').format(trip.rangeEnd);
                    return Slidable(
                      key: Key(trip.id),
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
                        tileColor: Colors.cyan.shade50,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.cyan.shade100,
                          radius: 30,
                          child: const Icon(
                            Icons.check,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          trip.destination,
                          style: const TextStyle(fontSize: 20),
                        ),
                        subtitle: Text("Completed $rangeEnd"),
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
                  itemCount: tripListCompleted.value.length,
                )
              : const Center(
                  child: Text("No trip"),
                );
        },
      ),
    );
  }
}
