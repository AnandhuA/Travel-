import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';

class TripDetailsScreen extends StatelessWidget {
  final int index;
  const TripDetailsScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final TripModel trip = tripList.value[index];
    return Scaffold(
      body: Center(child: Text(trip.destination)),
    );
  }
}
