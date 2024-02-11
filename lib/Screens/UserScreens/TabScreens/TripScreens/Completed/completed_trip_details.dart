// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Screens/UserScreens/TabScreens/TripScreens/Completed/add_blog.dart';
import 'package:travel/Styles/colors.dart';
import 'package:travel/Widgets/image_view.dart';

class CompletedTripDetails extends StatefulWidget {
  final TripModel trip;
  const CompletedTripDetails({super.key, required this.trip});

  @override
  State<CompletedTripDetails> createState() => _CompletedTripDetailsState();
}

class _CompletedTripDetailsState extends State<CompletedTripDetails> {
  bool _photosEmpty = true;
  bool _blogEmpty = true;
  @override
  void initState() {
    for (var value in completedTripList.value) {
      if (value.tripId == widget.trip.id) {
        _photosEmpty = false;
      }
    }
    for (var value in completedTripListBlog.value) {
      if (value.tripId == widget.trip.id) {
        _blogEmpty = false;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String start = DateFormat('dd MMM yyyy').format(widget.trip.rangeStart);
    String end = DateFormat('dd MMM yyyy').format(widget.trip.rangeEnd);
    List<CompletedTripModelBlog> blog = [];
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.event_add,
        children: [
          SpeedDialChild(
            onTap: () async {
              List<XFile> photos = await ImagePicker().pickMultiImage();

              Future.forEach(photos, (element) async {
                await addMemories(
                  completedTrip: CompletedTripModelPhotos(
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    photos: element.path,
                    tripId: widget.trip.id,
                  ),
                );
                completedTripList.notifyListeners();
              });
            },
            child: const Icon(Icons.add_photo_alternate_outlined),
            label: "Add Photos",
          ),
          SpeedDialChild(
            onTap: () {
              blog.isEmpty
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddBlogScreen(
                          trip: widget.trip,
                        ),
                      ),
                    )
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddBlogScreen(
                          trip: widget.trip,
                          blog: blog[0],
                        ),
                      ),
                    );
            },
            child: const Icon(Icons.message_outlined),
            label: "About trip",
          )
        ],
      ),
      appBar: AppBar(
        title: Text(widget.trip.destination),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: completedTripListBlog,
          builder: (context, value, child) {
            for (var value in completedTripListBlog.value) {
              if (value.tripId == widget.trip.id) {
                blog.add(value);
                _blogEmpty = true;
              }
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "To ${widget.trip.destination}",
                    style: const TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    "Start on $start to $end",
                    style: const TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  _blogEmpty
                      ? const SizedBox()
                      : const Text(
                          "About Trip",
                          style: TextStyle(fontSize: 25),
                        ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  blog.isNotEmpty ? Text(blog[0].blog) : const SizedBox(),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  _photosEmpty
                      ? const SizedBox()
                      : const Text(
                          "Photos",
                          style: TextStyle(fontSize: 25),
                        ),
                  ValueListenableBuilder(
                    valueListenable: completedTripList,
                    builder: (context, value, child) {
                      List<CompletedTripModelPhotos> lis = [];
                      List<String> imgs = [];
                      for (var value in completedTripList.value) {
                        if (value.tripId == widget.trip.id) {
                          lis.add(value);
                          imgs.add(value.photos);
                          _photosEmpty = true;
                        }
                      }
                      return lis.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.3,
                                ),
                                const Center(
                                  child: Text("Add images"),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: size.height * 1,
                              child: MasonryGridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: lis.length > 6 ? 6 : lis.length,
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: lis.length > 6 && index == 5
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImageView(
                                                      image: imgs,
                                                      initialIndex: index + 1,
                                                      local: true,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    height: 200,
                                                    width: double.infinity,
                                                    child: Image.file(
                                                      File(
                                                        lis[index + 1].photos,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 200,
                                                    color: transperantcolor,
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.photo_library,
                                                            color: grey700,
                                                          ),
                                                          Text(
                                                            "More Photos",
                                                            style: TextStyle(
                                                              fontSize: 25,
                                                              color: grey800,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : InkWell(
                                              onLongPress: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text("Delete"),
                                                      content: const Text(
                                                        "Are you sure you want to delete?",
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            removeImage(
                                                              completedTrip:
                                                                  lis[index],
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text("Yes"),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text("No"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImageView(
                                                      image: imgs,
                                                      initialIndex: index,
                                                      local: true,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Image.file(
                                                File(lis[index].photos),
                                              ),
                                            ),
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
