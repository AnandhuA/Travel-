import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/Functions/functions.dart';
import 'package:travel/Models/model.dart';
import 'package:travel/Screens/AdminScreens/place_details_screen.dart';
import 'package:travel/Widgets/bottom_sheet.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/dotted_container.dart';
import 'package:travel/Widgets/hot_places.dart';
import 'package:travel/Widgets/text_field_widet.dart';
import 'package:travel/colors.dart';

class EditPlaceScreen extends StatefulWidget {
  final PlaceModel placeModel;
  final int index;
  const EditPlaceScreen(
      {super.key, required this.placeModel, required this.index});

  @override
  State<EditPlaceScreen> createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlaceScreen> {
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late List<XFile> file;
  List<String> image = [];
  List<Map<String, String>> list = [];

  @override
  void initState() {
    super.initState();
    list = widget.placeModel.hotplace.map((Map<dynamic, dynamic> map) {
      return Map<String, String>.from(map);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    image = widget.placeModel.image;

    hotplacesList = list;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Place Details"),
        actions: [
          Image.asset(
            "Assets/Images/01.png",
            width: 200,
          )
        ],
        backgroundColor: const Color(0xfffdf6f6),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(gradient: backgroundGradient2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textField(
                    label: "Edit place",
                    controller: placeController,
                    text: widget.placeModel.place),
                const SizedBox(
                  height: 10,
                ),
                textField(
                    label: "Edit District",
                    controller: districtController,
                    text: widget.placeModel.district),
                const SizedBox(
                  height: 20,
                ),
                textField(
                    label: "Edit Description",
                    line: 4,
                    controller: descriptionController,
                    text: widget.placeModel.description),
                const SizedBox(
                  height: 20,
                ),
                image.isEmpty
                    ? InkWell(
                        onTap: () async {
                          file = await ImagePicker().pickMultiImage();
                          await Future.forEach(file, (element) {
                            image.add(element.path);
                          });
                          setState(() {
                            image = image;
                          });
                        },
                        child: dottedContainer(
                            text: "Add Image",
                            height: 200,
                            width: double.infinity,
                            icon: Icons.camera_alt_outlined),
                      )
                    : SizedBox(
                        height: 290,
                        width: double.infinity,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                image.clear();
                                file = await ImagePicker().pickMultiImage();
                                await Future.forEach(
                                    file, (element) => image.add(element.path));
                                setState(() {
                                  image = image;
                                });
                              },
                              child: SizedBox(
                                height: 220,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    File(image[0]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: image.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: 80,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Image.file(
                                          File(image[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Hot places"),
                const SizedBox(
                  height: 20,
                ),
                list.isEmpty ? const SizedBox() : const HotPlaceAdd(),
                InkWell(
                  onTap: () async {
                    await addHotPlacebottomSheet(context);
                    setState(() {
                      list = hotplacesList;
                    });
                  },
                  child: dottedContainer(
                      text: "Add Hot Places",
                      height: 100,
                      width: 100,
                      icon: Icons.add),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                addButton(
                  color: buttonColor,
                  add: "Update",
                  onpress: () async {
                    if (districtController.text.isEmpty ||
                        placeController.text.isEmpty ||
                        descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Fill all details"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      PlaceModel place = PlaceModel(
                        id: widget.placeModel.id,
                        hotplace: list,
                        place: placeController.text,
                        image: widget.placeModel.image,
                        district: districtController.text,
                        description: descriptionController.text,
                        categories: widget.placeModel.categories,
                      );
                      await updatePlace(place: place);
                      navigate();
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigate() {
    Navigator.pop(context);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: ((context) => PlaceDetailsScreen(index: widget.index)),
        ));
  }
}
