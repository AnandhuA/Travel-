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
  AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlaceScreen> {
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late XFile? file;
  String image = "";
  String? categorie;
  List<HotPlaceModel> list = [];

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
              InkWell(
                onTap: () async {
                  file = (await ImagePicker()
                      .pickImage(source: ImageSource.gallery));
                  if (file != null) {
                    setState(() {
                      image = file!.path;
                    });
                  }
                },
                child: image.isEmpty
                    ? dottedContainer(
                        text: "Add Image",
                        height: 200,
                        width: double.infinity,
                        icon: Icons.camera_alt_outlined)
                    : SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(image),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
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
              addButton(onpress: () {
                if (dropdownValue() != null) {
                  categorie = dropdownValue()!;
                }
                addPlace(
                    categorie: categorie!,
                    place: placeController.text,
                    district: districtController.text,
                    description: descriptionController.text,
                    image: image,
                    list: list);

                Navigator.pushReplacementNamed(context, "HomePage");
              })
            ],
          ),
        ),
      ),
    );
  }
}
