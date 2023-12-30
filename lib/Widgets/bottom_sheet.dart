import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/Functions/functions.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/text_field_widet.dart';

Future bottomSheet(ctx) {
  TextEditingController placeController = TextEditingController();
  late XFile file;
  return showModalBottomSheet(
      context: ctx,
      builder: (BuildContext context) {
        return SizedBox(
          height: 400,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                const Text("Add place"),
                Textfield(label: "place", controller: placeController),
                const SizedBox(
                  height: 30,
                ),
                TextButton.icon(
                    onPressed: () async {
                      file = (await ImagePicker()
                          .pickImage(source: ImageSource.gallery))!;
                    },
                    icon: const Icon(Icons.photo_library_outlined),
                    label: const Text("Select image")),
                const SizedBox(
                  height: 30,
                ),
                addButton(onpress: () {
                  addHotPlace(place: placeController.text, image: file.path);
                })
              ],
            ),
          ),
        );
      });
}
