import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel/Functions/functions.dart';
import 'package:travel/Models/model.dart';

class HotPlaceAdd extends StatefulWidget {
  const HotPlaceAdd({super.key});

  @override
  State<HotPlaceAdd> createState() => _HotPlaceAddState();
}

class _HotPlaceAddState extends State<HotPlaceAdd> {
  @override
  Widget build(BuildContext context) {
    return hotplacesList.isEmpty?const SizedBox():
    SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                HotPlaceModel hotplace = hotplacesList[index];
                return Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Image.file(
                              File(hotplace.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                hotplacesList.removeAt(index);
                              });
                            },
                            child: const CircleAvatar(
                              radius: 10,
                              child: Icon(
                                Icons.close,
                                size: 15,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Text(hotplace.place),
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 20,
                );
              },
              itemCount: hotplacesList.length,
            ),
          );
  }
}
