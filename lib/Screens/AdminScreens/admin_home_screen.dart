import 'package:flutter/material.dart';
import 'package:travel/Functions/admin_functions.dart';
import 'package:travel/Models/admin_model.dart';
import 'package:travel/Screens/AdminScreens/place_details_screen.dart';
import 'package:travel/Widgets/bottom_sheet.dart';
import 'package:travel/Widgets/drawer_wedget.dart';
import 'package:travel/Widgets/home_page_wedgets.dart';
import 'package:travel/colors.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset(
            "Assets/Images/00.png",
            width: 170,
          ),
          const SizedBox(
            width: 30,
          )
        ],
        backgroundColor: const Color(0xffffffff),
      ),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(gradient: backgroundGradient1),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 30),
                ),
                TextButton.icon(
                  onPressed: () {
                    getPlaces();
                    addCategoriesbottomSheet(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: buttonColor,
                  ),
                  label: const Text(
                    "Add categories",
                    style: TextStyle(color: buttonColor),
                  ),
                )
              ]),
              Container(
                margin: const EdgeInsets.only(top: 15),
                height: 50,
                child: ValueListenableBuilder(
                    valueListenable: categorieList,
                    builder: ((context, List<CategoriesModel> value, child) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.length,
                          itemBuilder: (BuildContext context, int index) {
                            return categories(index: index, context: context);
                          });
                    })),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Places",
                    style: TextStyle(fontSize: 30),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, "AddPlace");
                    },
                    icon: const Icon(
                      Icons.add,
                      color: buttonColor,
                    ),
                    label: const Text(
                      "Add new place",
                      style: TextStyle(color: buttonColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: placeList,
                  builder: (context, value, child) {
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: placeList.value.length,
                        itemBuilder: ((context, index) {
                          PlaceModel place = placeList.value[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      PlaceDetailsScreen(index: index)),
                                ),
                              );
                            },
                            child: places(
                                image: place.image[0],
                                place: place.place,
                                district: place.district),
                          );
                        }));
                  },
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
