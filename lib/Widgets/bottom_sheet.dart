// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/Functions/admin_functions.dart';
import 'package:travel/Models/admin_model.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/text_field_widet.dart';
import 'package:travel/colors.dart';

ValueNotifier<List<Map<String, String>>> hotplacesList = ValueNotifier([]);

Future addHotPlacebottomSheet(ctx) {
  TextEditingController placeController = TextEditingController();
  late XFile? file;
  String image = "";

  return showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(gradient: backgroundGradient2),
            height: 700,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  const Text("Add place"),
                  textField(label: "place", controller: placeController),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      file = (await ImagePicker()
                          .pickImage(source: ImageSource.gallery));
                      if (file != null) {
                        image = file!.path;
                      }
                    },
                    icon: const Icon(Icons.photo_library_outlined),
                    label: const Text("Select image"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  addButton(
                      color: buttonColor,
                      onpress: () {
                        if (placeController.text.isNotEmpty &&
                            image.isNotEmpty) {
                          hotplacesListMap = {
                            "Image": image,
                            "Place": placeController.text
                          };
                          hotplacesList.value.add(hotplacesListMap);
                          hotplacesList.notifyListeners();
                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            ),
          ),
        );
      });
}

Future addCategoriesbottomSheet(ctx) {
  TextEditingController categorieController = TextEditingController();

  return showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(gradient: backgroundGradient2),
            height: 700,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  const Text("Add Categorie"),
                  textField(
                      label: "Categories", controller: categorieController),
                  const SizedBox(
                    height: 30,
                  ),
                  addButton(
                      color: buttonColor,
                      onpress: () {
                        if (categorieController.text.isNotEmpty) {
                          CategoriesModel categorie = CategoriesModel(
                              id: DateTime.now()
                                  .microsecondsSinceEpoch
                                  .toString(),
                              categorie: categorieController.text);
                          addCategories(categories: categorie);
                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            ),
          ),
        );
      });
}
