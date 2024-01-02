import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel/Functions/functions.dart';

Widget categories({required int index, required BuildContext context}) {
  final categorie = categorieList.value[index];
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 245, 234, 182),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Text(
          categorie.categorie,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    ),
  );
}

Widget places(
    {required String image, required String place, required String district}) {
  return Column(
    children: [
      SizedBox(
        height: 120,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          child: Image.file(
            File(image),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      Container(
        height: 45,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 245, 234, 182),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.location_on_outlined),
            Text(
              place,
            ),
            Text(district)
          ],
        ),
      )
    ],
  );
}
