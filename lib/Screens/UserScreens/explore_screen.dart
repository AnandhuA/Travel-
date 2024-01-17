import 'package:flutter/material.dart';
import 'package:travel/Functions/admin_functions.dart';
import 'package:travel/Models/admin_model.dart';
import 'package:travel/Screens/AdminScreens/place_details_screen.dart';
import 'package:travel/Widgets/home_page_wedgets.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "   Explore",
              style: TextStyle(fontSize: 35),
            ),
            const SizedBox(
              height: 30,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: placeList.value.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
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
              },
            )
          ],
        ),
      ),
    );
  }
}
