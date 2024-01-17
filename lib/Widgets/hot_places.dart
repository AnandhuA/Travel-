// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel/Widgets/bottom_sheet.dart';
import 'package:travel/colors.dart';

class HotPlaceAdd extends StatelessWidget {
  const HotPlaceAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return hotplacesList.value.isEmpty
        ? const SizedBox()
        : SizedBox(
            height: 100,
            child: ValueListenableBuilder(
              valueListenable: hotplacesList,
              builder: (context, value, child) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Map hotplace = hotplacesList.value[index];
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
                                  File(hotplace["Image"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  hotplacesList.value.removeAt(index);
                                  hotplacesList.notifyListeners();
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
                          decoration: const BoxDecoration(
                            color: lightColor,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            child: Text(
                              hotplace["Place"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
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
                  itemCount: hotplacesList.value.length,
                );
              },
            ));
  }
}
