import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel/Functions/functions.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final int index;
  PlaceDetailsScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final place = placesList[index];

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 400,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(30)),
                child: Image.file(
                  File(place.image),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: SafeArea(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                place.place,
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Text(
                ",${place.district}",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Description",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(place.description),
        )
      ],
    ));
  }
}
