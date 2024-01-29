import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel/FireBase/firebase_functions.dart';
import 'package:travel/Models/admin_model.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/text_field_widet.dart';
import 'package:travel/Styles/colors.dart';

Widget categories({required int index, required BuildContext context}) {
  final categorie = categorieListener.value[index];
  final FirestroreService firestroreService = FirestroreService();
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
    decoration: BoxDecoration(
      color: lightColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Row(children: [
          Text(
            categorie.categorie,
            style: const TextStyle(fontSize: 20),
          ),
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () {
                  TextEditingController categorieController =
                      TextEditingController();
                  categorieController.text = categorie.categorie;
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: backgroundGradient2,
                            ),
                            height: 700,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              child: Column(
                                children: [
                                  const Text("Add Categorie"),
                                  textField(
                                      label: "Categories",
                                      controller: categorieController),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  addButton(
                                      add: "Update",
                                      color: buttonColor,
                                      onpress: () {
                                        if (categorieController
                                            .text.isNotEmpty) {
                                          CategoriesModel categoriemodel =
                                              CategoriesModel(
                                            id: categorie.id,
                                            categorie: categorieController.text,
                                          );
                                          firestroreService.editCategories(
                                              categoriesModel: categoriemodel);
                                          Navigator.pop(context);
                                        }
                                      })
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: const SizedBox(
                  height: 20,
                  width: 50,
                  child: Text("Edit"),
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                            title: const Text("Delete"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: const Text("NO"),
                              ),
                              TextButton(
                                onPressed: () {
                                  firestroreService.deleteCategorie(
                                      categoriesModel: categorie);
                                  Navigator.pop(ctx);
                                },
                                child: const Text("Yes"),
                              )
                            ]);
                      });
                },
                child: const SizedBox(
                  height: 20,
                  width: 50,
                  child: Text("Delete"),
                ),
              )
            ];
          })
        ]),
      ),
    ),
  );
}

Widget places(
    {required String image,
    required String place,
    required String district,
    required BuildContext context}) {
  final double screenHeight = MediaQuery.of(context).size.height;
  final double screenWidth = MediaQuery.of(context).size.width;
  return Column(children: [
    SizedBox(
      height: screenHeight * 0.125,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: CachedNetworkImage(
          imageUrl: image,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              color: purple100,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      height: screenHeight * 0.05,
      decoration: const BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Row(children: [
        SizedBox(
          width: screenWidth * 0.03,
        ),
        const Icon(Icons.location_on_outlined),
        Text("$place,"),
        Expanded(
          child: Text(
            district,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ]),
    )
  ]);
}
