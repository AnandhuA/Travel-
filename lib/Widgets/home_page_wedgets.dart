import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel/Functions/functions.dart';
import 'package:travel/colors.dart';

Widget categories({required int index, required BuildContext context}) {
  final categorie = categorieList.value[index];
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
    decoration: BoxDecoration(
      color: lightColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Row(children: [
          Text(
            categorie.categorie,
            style: const TextStyle(fontSize: 20),
          ),
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                            title: const Text("Delete"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: const Text("NO"),
                              ),
                              TextButton(
                                onPressed: () {
                                  deleteCategorie(categories: categorie);
                                  Navigator.pop(ctx);
                                },
                                child: const Text("Yes"),
                              )
                            ]);
                      });
                },
                child: const SizedBox(
                  height: 20,
                  width: 50,
                  child: Text("Delete"),
                ),
              )
            ];
          })
        ]),
      ),
    ),
  );
}

Widget places(
    {required String image, required String place, required String district}) {
  return Column(children: [
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
        color: lightColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Row(children: [
        const SizedBox(
          width: 10,
        ),
        const Icon(Icons.location_on_outlined),
        Text(
          "$place, ",
        ),
        Text(district)
      ]),
    )
  ]);
}
