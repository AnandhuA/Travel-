import 'dart:io';
import 'package:flutter/material.dart';
import 'package:travel/Functions/admin_functions.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Screens/AdminScreens/edit_place.dart';
import 'package:travel/Widgets/details_page_image.dart';
import 'package:travel/colors.dart';
import 'package:travel/main.dart';
import 'package:travel/style.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final int index;
  final bool fav;
  const PlaceDetailsScreen({super.key, required this.index, this.fav = false});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final place =
        fav ? favoriteList.value[index].favoritePlace : placeList.value[index];

    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DetailsPageImage(
          place: place,
          ctx: context,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(gradient: backgroundGradient2),
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child:
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(place.place, style: textStyle2),
                  Text(", ${place.district}", style: textStyle3),
                ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                ),
                child: Text(
                  place.categories.categorie,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                ),
                child: const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                ),
                child: Text(place.description),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                ),
                child: place.hotplace.isEmpty
                    ? const SizedBox()
                    : Text("Hot Places", style: textStyle4),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: place.hotplace.length,
                  itemBuilder: (context, index) {
                    Map hotplace = place.hotplace[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                      ),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                onVerticalDragDown: (_) {
                                  Navigator.of(context).pop();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      color: purple100,
                                      child: Center(
                                        child: Text(hotplace["Place"]),
                                      ),
                                    ),
                                    Image.file(File(hotplace["Image"])),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Column(children: [
                          SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              child: Image.file(
                                File(hotplace["Image"]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: lightColor,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10),
                              ),
                            ),
                            height: 30,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.03,
                              ),
                              child: Center(
                                child: Text(
                                  hotplace["Place"],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                    );
                  }),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              admin
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: screenWidth * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(color: red),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: buttonbg,
                                ),
                                onPressed: () {
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
                                                deletePlace(place.id);
                                                Navigator.pop(ctx);
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Yes"),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Text("Delete", style: textStyle5),
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.4,
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: buttonColor,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => EditPlaceScreen(
                                              placeModel: place,
                                              index: index,
                                            )),
                                      ));
                                },
                                child: Text("Edit", style: textStyle6),
                              ),
                            ),
                          ]),
                    )
                  : const SizedBox(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
