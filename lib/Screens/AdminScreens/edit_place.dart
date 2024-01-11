// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:travel/Functions/functions.dart';
import 'package:travel/Models/model.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/text_field_widet.dart';
import 'package:travel/colors.dart';

class EditPlaceScreen extends StatefulWidget {
  const EditPlaceScreen({
    super.key,
    required this.placeModel,
  });
  final PlaceModel placeModel;

  @override
  State<EditPlaceScreen> createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlaceScreen> {
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                addButton(
                  color: buttonColor,
                    add: "Update",
                    onpress: () async {
                      if (districtController.text.isEmpty ||
                          placeController.text.isEmpty ||
                          descriptionController.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Fill all details"),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        PlaceModel place = PlaceModel(
                          id: widget.placeModel.id,
                          hotplace: widget.placeModel.hotplace,
                          place: placeController.text,
                          image: widget.placeModel.image,
                          district: districtController.text,
                          description: descriptionController.text,
                          categories: widget.placeModel.categories,
                        );
                        updatePlace(place: place);
                        refresh();
                        Navigator.pop(context);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
