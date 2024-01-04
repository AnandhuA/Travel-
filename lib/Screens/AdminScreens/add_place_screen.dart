// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/Functions/functions.dart';
import 'package:travel/Models/model.dart';
import 'package:travel/Widgets/bottom_sheet.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/categories_dropdown.dart';
import 'package:travel/Widgets/dotted_container.dart';
import 'package:travel/Widgets/hot_places.dart';
import 'package:travel/Widgets/text_field_widet.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlaceScreen> {
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late List<XFile> file;
  List<String> image = [];

  String? categorie;
  List list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Place"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textField(label: "Add place", controller: placeController),
              const SizedBox(
                height: 10,
              ),
              textField(label: "District", controller: districtController),
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
                      child: Column(children: [
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
                                fit: BoxFit.fitWidth,
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
                      ]),
                    ),
              textField(
                  label: "Description",
                  line: 4,
                  controller: descriptionController),
              const SizedBox(
                height: 20,
              ),
              const CategoriesDropdown(),
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
              addButton(onpress: () async {
                if (districtController.text.isEmpty ||
                    placeController.text.isEmpty ||
                    descriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Fill all details"),
                    backgroundColor: Colors.red,
                  ));
                } else if (image.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Select image"),
                    backgroundColor: Colors.red,
                  ));
                } else if (dropdownValue() == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Select categorey"),
                    backgroundColor: Colors.red,
                  ));
                } else {
                  categorie = dropdownValue();
                  PlaceModel place = PlaceModel(
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    hotplace: hotplacesList,
                    place: placeController.text,
                    image: image,
                    district: districtController.text,
                    description: descriptionController.text,
                    categories: categorie!,
                  );
                  await addPlace(place: place);
                  hotplacesList.clear();
                  Navigator.pop(context);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
