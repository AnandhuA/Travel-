import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:travel/FireBase/firebase_functions.dart';
import 'package:travel/FireBase/image_upload.dart';
import 'package:travel/Models/admin_model.dart';
import 'package:travel/Screens/AdminScreens/place_details_screen.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/text_field_widet.dart';
import 'package:travel/Styles/colors.dart';

class EditPlaceScreen extends StatefulWidget {
  final PlaceModel firebasePlaceModel;
  final int index;
  const EditPlaceScreen(
      {super.key, required this.firebasePlaceModel, required this.index});

  @override
  State<EditPlaceScreen> createState() => _EditPlaceState();
}

List<String> image = [];
List<String> urlsOfImage = [];

class _EditPlaceState extends State<EditPlaceScreen> {
  bool lodaing = false;
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late List<XFile> file;
  final FirestroreService firestroreService = FirestroreService();
  List<Map<String, String>> list = [];

  // @override
  // void initState() {
  //   super.initState();
  //   list = widget.firebasePlaceModel.hotplace.map((Map<dynamic, dynamic> map) {
  //     return Map<String, String>.from(map);
  //   }).toList();
  // }

  @override
  Widget build(BuildContext context) {
    List<String> firebaseImageList = widget.firebasePlaceModel.image;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Place Details"),
        actions: [
          Image.asset(
            "Assets/Images/01.png",
            width: 200,
          )
        ],
        backgroundColor: white,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: backgroundGradient2,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textField(
                    label: "Edit place",
                    controller: placeController,
                    text: widget.firebasePlaceModel.place),
                const SizedBox(
                  height: 10,
                ),
                textField(
                    label: "Edit District",
                    controller: districtController,
                    text: widget.firebasePlaceModel.district),
                const SizedBox(
                  height: 20,
                ),
                textField(
                    label: "Edit Description",
                    line: 4,
                    controller: descriptionController,
                    text: widget.firebasePlaceModel.description),
                const SizedBox(
                  height: 20,
                ),
                image.isNotEmpty
                    ? SizedBox(
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
                                  child: Image.network(
                                    firebaseImageList[0],
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
                                  itemCount: firebaseImageList.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: 80,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Image.network(
                                          firebaseImageList[index],
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
                // const Text("Hot places"),
                // const SizedBox(
                //   height: 20,
                // ),
                // list.isEmpty ? const SizedBox() : const HotPlaceAdd(),
                // InkWell(
                //   onTap: () async {
                //     await addHotPlacebottomSheet(context);
                //     setState(() {
                //       list = hotplacesList.value;
                //     });
                //   },
                //   child: dottedContainer(
                //       text: "Add Hot Places",
                //       height: 100,
                //       width: 100,
                //       icon: Icons.add),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                const SizedBox(
                  height: 20,
                ),
                lodaing
                    ? Lottie.asset(
                        "Assets/Animations/loading.json",
                      )
                    : addButton(
                        color: buttonColor,
                        add: "Update",
                        onpress: () async {
                          if (districtController.text.isEmpty ||
                              placeController.text.isEmpty ||
                              descriptionController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Fill all details"),
                                backgroundColor: red,
                              ),
                            );
                          } else {
                            // PlaceModel place = PlaceModel(
                            //   id: widget.placeModel.id,
                            //   hotplace: list,
                            //   place: placeController.text,
                            //   image: widget.placeModel.image,
                            //   district: districtController.text,
                            //   description: descriptionController.text,
                            //   categories: widget.placeModel.categories,
                            // );
                            // await updatePlace(place: place);
                            setState(() {
                              lodaing = true;
                            });
                            if (image.isNotEmpty) {
                              urlsOfImage = await uploadImage(images: file);
                            }
                            firestroreService.updatePlace(
                                id: widget.firebasePlaceModel.id,
                                place: placeController.text,
                                district: districtController.text,
                                description: descriptionController.text,
                                categorie: widget.firebasePlaceModel.categories,
                                images: urlsOfImage.isEmpty
                                    ? firebaseImageList
                                    : urlsOfImage);
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
