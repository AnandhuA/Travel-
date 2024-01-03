import 'package:flutter/material.dart';
import 'package:travel/Functions/functions.dart';
import 'package:travel/Models/model.dart';
import 'package:travel/Screens/AdminScreens/place_details_screen.dart';
import 'package:travel/Widgets/bottom_sheet.dart';
import 'package:travel/Widgets/drawer_wedget.dart';
import 'package:travel/Widgets/home_page_wedgets.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    refresh();
    return Scaffold(
      appBar: AppBar(),
      drawer: drawer(context),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search"),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 30),
                ),
                TextButton.icon(
                    onPressed: () {
                      getPlaces();

                      addCategoriesbottomSheet(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add categories"))
              ],
            ),
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
                  icon: const Icon(Icons.add),
                  label: const Text("Add new place"),
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
                  refresh();
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
          ],
        ),
      ),
    );
  }
}
