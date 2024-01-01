import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/Functions/functions.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/text_field_widet.dart';

Future addHotPlacebottomSheet(ctx) {
  TextEditingController placeController = TextEditingController();
  late XFile? file;
  String image = "";

  return showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: SizedBox(
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
                      label: const Text("Select image")),
                  const SizedBox(
                    height: 30,
                  ),
                  addButton(onpress: () {
                    if (placeController.text.isNotEmpty && image.isNotEmpty) {
                      addHotPlace(place: placeController.text, image: image);
                      Navigator.pop(context);
                    } else if (placeController.text.isEmpty) {
                    } else if (image.isEmpty) {}
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
          child: SizedBox(
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
                  addButton(onpress: () {
                    addCategories(categories: categorieController.text);
                    Navigator.pop(context);
                  })
                ],
              ),
            ),
          ),
        );
      });
}
