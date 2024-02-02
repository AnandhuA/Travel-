import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Notifications/show_notification.dart';
import 'package:travel/Screens/UserScreens/EditTrip/edit_trip_screen.dart';
import 'package:travel/Screens/UserScreens/TabScreens/TripScreens/Upcoming/trip_details_page.dart';
import 'package:travel/Styles/colors.dart';

class TripListTile extends StatefulWidget {
  final TripModel trip;
  final bool tripNow;
  final int index;
  final BuildContext context;
  const TripListTile({
    super.key,
    required this.trip,
    required this.tripNow,
    required this.context,
    required this.index,
  });

  @override
  State<TripListTile> createState() => _TripListTileState();
}

class _TripListTileState extends State<TripListTile> {
  late String dateTrailing;
  late String day;
  late String week;
  late String start;
  late String end;
  late bool tripNow;
  @override
  void initState() {
    TripModel trip = tripList.value[widget.index];
    DateTime now = DateTime.now();
    dateTrailing = DateFormat('MMM yyyy').format(trip.rangeStart);
    day = DateFormat('dd').format(trip.rangeStart);
    week = DateFormat('EEE').format(trip.rangeStart);
    start = DateFormat('dd MMM yyyy').format(trip.rangeStart);
    end = DateFormat('dd MMM yyyy').format(trip.rangeEnd);
    tripNow = widget.tripNow;
    if (trip.rangeStart.isBefore(now) && trip.rangeEnd.isAfter(now)) {
      tripNow = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TripModel trip = widget.trip;
    final size = MediaQuery.of(widget.context).size;

    return Slidable(
      key: Key(trip.id.toString()),
      startActionPane: ActionPane(
        extentRatio:
            !convertDateTime(trip: trip).isAfter(DateTime.now()) ? 0.2 : 0.5,
        motion: const StretchMotion(),
        children: !convertDateTime(trip: trip).isAfter(DateTime.now())
            ? [
                SlidableAction(
                  backgroundColor: blue100,
                  autoClose: true,
                  onPressed: (contex) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTripScreen(
                          editTrip: trip,
                          onGoing: widget.tripNow,
                        ),
                      ),
                    );
                  },
                  foregroundColor: blue,
                  icon: Icons.edit_note_sharp,
                  label: "Edit",
                ),
              ]
            : [
                SlidableAction(
                  backgroundColor: blue100,
                  autoClose: true,
                  onPressed: (contex) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTripScreen(
                          editTrip: trip,
                          onGoing: widget.tripNow,
                        ),
                      ),
                    );
                  },
                  foregroundColor: blue,
                  icon: Icons.edit_note_sharp,
                  label: "Edit",
                ),
                SlidableAction(
                  backgroundColor: orange100,
                  autoClose: true,
                  onPressed: (contex) {
                    trip.notification
                        ? enableAndDisableNotification(val: false, trip: trip)
                        : enableAndDisableNotification(val: true, trip: trip);
                  },
                  foregroundColor: orange,
                  icon: trip.notification
                      ? Icons.notifications_off_outlined
                      : Icons.notifications_active_outlined,
                  label: trip.notification ? "Disable" : "Enable",
                ),
              ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: red50,
            autoClose: true,
            onPressed: (context) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text("Delete successfully"),
                  backgroundColor: black,
                ),
              );
              cancelNotification(id: trip.id);
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TripDetailsScreen(
                  trip: trip,
                ),
              ));
        },
        tileColor: tripNow ? orange50 : green50,
        contentPadding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.017,
        ),
        leading: CircleAvatar(
          backgroundColor: tripNow ? orange100 : green100,
          radius: 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                week,
                style: TextStyle(
                  color: grey800,
                ),
              )
            ],
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              trip.destination,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            convertDateTime(trip: trip).isAfter(DateTime.now())
                ? trip.notification
                    ? const Icon(
                        Icons.notifications_active_outlined,
                        size: 15,
                      )
                    : const Icon(
                        Icons.notifications_off_outlined,
                        size: 15,
                      )
                : const SizedBox()
          ],
        ),
        subtitle: tripNow ? Text("$start to $end") : null,
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              trip.time,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
            Text(
              dateTrailing,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  enableAndDisableNotification({required bool val, required TripModel trip}) {
    addTrip(
      trip: TripModel(
        id: trip.id,
        destination: trip.destination,
        description: trip.description,
        time: trip.time,
        rangeStart: trip.rangeStart,
        rangeEnd: trip.rangeEnd,
        uid: trip.uid,
        travelType: trip.travelType,
        numberOfPeople: trip.numberOfPeople,
        budget: trip.budget,
        activitys: trip.activitys,
        notification: val,
      ),
    );
    DateTime tripDateTime = convertDateTime(trip: trip);
    val
        ? showNotification(
            date: tripDateTime,
            title: trip.destination,
            body: trip.description,
            id: trip.id)
        : cancelNotification(id: trip.id);
  }
}
