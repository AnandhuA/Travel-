import 'package:flutter/material.dart';
import 'package:travel/FireBase/firebase_functions.dart';
import 'package:travel/Models/admin_model.dart';
import 'package:travel/Screens/AdminScreens/place_details_screen.dart';
import 'package:travel/Widgets/home_page_wedgets.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "    Explore",
              style: TextStyle(fontSize: 35),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: placeModelListener.value.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.05,
                crossAxisSpacing: screenWidth * 0.02,
              ),
              itemBuilder: (context, index) {
                PlaceModel place = placeModelListener.value[index];
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
                      context: context,
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
