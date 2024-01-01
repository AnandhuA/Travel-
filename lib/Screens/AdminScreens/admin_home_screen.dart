import 'package:flutter/material.dart';
import 'package:travel/Functions/functions.dart';
import 'package:travel/Models/model.dart';
import 'package:travel/Screens/AdminScreens/place_details_screen.dart';
import 'package:travel/Widgets/drawer_wedget.dart';
import 'package:travel/Widgets/home_page_wedgets.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text("Add categories"))
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return categories();
                  }),
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
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: placesList.length,
                  itemBuilder: ((context, index) {
                    PlaceModel place = placesList[index];
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
                          image: place.image,
                          place: place.place,
                          district: place.district),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
