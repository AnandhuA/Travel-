import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Widgets/trip_list_tile.dart';

class UpcomingTrip extends StatelessWidget {
  const UpcomingTrip({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: tripList,
        builder: (context, value, child) {
          return tripList.value.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    return TripListTile(
                        trip: tripList.value[index],
                        tripNow: false,
                        context: context,
                        index: index);
                    // TripModel trip = tripList.value[index];
                    // DateTime now = DateTime.now();
                    // String dateTrailing =
                    //     DateFormat('MMM yyyy').format(trip.rangeStart);
                    // String day = DateFormat('dd').format(trip.rangeStart);
                    // String week = DateFormat('EEE').format(trip.rangeStart);
                    // String start =
                    //     DateFormat('dd MMM yyyy').format(trip.rangeStart);
                    // String end =
                    //     DateFormat('dd MMM yyyy').format(trip.rangeEnd);
                    // bool tripNow = false;
                    // if (trip.rangeStart.isBefore(now) &&
                    //     trip.rangeEnd.isAfter(now)) {
                    //   tripNow = true;
                    // }

                    // return Slidable(
                    //   key: Key(trip.id.toString()),
                    //   startActionPane: ActionPane(
                    //       extentRatio: 0.2,
                    //       motion: const StretchMotion(),
                    //       children: [
                    //         SlidableAction(
                    //           backgroundColor: blue100,
                    //           autoClose: true,
                    //           onPressed: (contex) {
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                   builder: (context) => EditTripScreen(
                    //                     editTrip: trip,
                    //                     onGoing: tripNow,
                    //                   ),
                    //                 ));
                    //           },
                    //           foregroundColor: blue,
                    //           icon: Icons.edit_note_sharp,
                    //           label: "Edit",
                    //         )
                    //       ]),
                    //   endActionPane: ActionPane(
                    //     extentRatio: 0.2,
                    //     motion: const StretchMotion(),
                    //     children: [
                    //       SlidableAction(
                    //         backgroundColor: red50,
                    //         autoClose: true,
                    //         onPressed: (context) {
                    //           ScaffoldMessenger.of(context)
                    //               .showSnackBar(const SnackBar(
                    //             duration: Duration(seconds: 1),
                    //             content: Text("Delete successfully"),
                    //             backgroundColor: black,
                    //           ));
                    //           cancelNotification(id: trip.id);
                    //           deleteTrip(trip: trip);
                    //         },
                    //         foregroundColor: red,
                    //         icon: Icons.delete,
                    //         label: "Delect",
                    //       ),
                    //     ],
                    //   ),
                    //   child: ListTile(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) =>
                    //                 TripDetailsScreen(trip: trip),
                    //           ));
                    //     },
                    //     tileColor: tripNow ? orange50 : green50,
                    //     contentPadding: EdgeInsets.symmetric(
                    //       horizontal: screenWidth * 0.04,
                    //       vertical: screenHeight * 0.017,
                    //     ),
                    //     leading: CircleAvatar(
                    //       backgroundColor: tripNow ? orange100 : green100,
                    //       radius: 30,
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           // SizedBox(),
                    //           Text(
                    //             day,
                    //             style: const TextStyle(fontSize: 12),
                    //           ),
                    //           Text(
                    //             week,
                    //             style: TextStyle(color: grey800),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //     title: Text(
                    //       trip.destination,
                    //       style: const TextStyle(fontSize: 20),
                    //     ),
                    //     subtitle: tripNow ? Text("$start to $end") : null,
                    //     trailing: Column(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         Text(
                    //           trip.time,
                    //           style: const TextStyle(fontSize: 13),
                    //         ),
                    //         Text(
                    //           dateTrailing,
                    //           style: const TextStyle(fontSize: 13),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // );
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
