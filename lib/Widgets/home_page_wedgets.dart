import 'package:flutter/material.dart';

Widget categories() {
  return Container(
    width: 125,
    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 167, 167, 167),
      borderRadius: BorderRadius.circular(20),
    ),
  );
}

Widget places() {
  return Column(
    children: [
      SizedBox(
        height: 120,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          child: Image.asset(
            "Assets/Images/Hampi.webp",
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      Container(
        height: 45,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        child: const Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(Icons.location_on_outlined),
            Text(
              "data",
            ),
            Text("data nnn")
          ],
        ),
      )
    ],
  );
}
