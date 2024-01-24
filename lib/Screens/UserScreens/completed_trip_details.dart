import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/colors.dart';

class CompletedTripDetails extends StatelessWidget {
  final int index;
  const CompletedTripDetails({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final TripModel trip = tripListCompleted.value[index];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
       
        tooltip: "Add",
        backgroundColor: cyan100,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Center(child: Text(trip.destination)),
    );
  }
}
