import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travel/Screens/UserScreens/account_screen.dart';
import 'package:travel/Screens/UserScreens/add_trip_screen.dart';
import 'package:travel/Screens/UserScreens/explore_screen.dart';
import 'package:travel/Screens/UserScreens/favorite_screen.dart';
import 'package:travel/Screens/UserScreens/trip_screen.dart';
import 'package:travel/Widgets/drawer_wedget.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int selectedindex = 0;
  final PageController _pageController = PageController();
  List<Widget> screen = [
    const ExploreScreen(),
    const MyTripsScreen(),
    AddTripScreen(),
    const FavoriteScreen(),
     AccountScreen()
  ];
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
      ),
      drawer: drawer(context),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
            onTabChange: (value) {
              setState(() {
                selectedindex = value;
                _pageController.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              });
              // setState(() {
              //   selectedindex = value;
              //   _pageController.animateToPage(
              //     value,
              //     duration: const Duration(milliseconds: 300),
              //     curve: Curves.easeInOut,
              //   );
              // });
            },
            padding: const EdgeInsets.all(10),
            gap: 10,
            selectedIndex: selectedindex,
            tabs: [
              GButton(
                haptic: true,
                iconColor: Colors.black,
                icon: Icons.home_outlined,
                text: "Home",
                iconActiveColor: Colors.purple,
                backgroundColor: Colors.purple.shade100,
                textColor: Colors.purple,
              ),
              GButton(
                haptic: true,
                iconColor: Colors.black,
                icon: Icons.category_outlined,
                text: "My Trips",
                iconActiveColor: Colors.green,
                backgroundColor: Colors.green.shade100,
                textColor: Colors.green,
              ),
              GButton(
                haptic: true,
                iconColor: Colors.black,
                icon: Icons.add_circle_outline,
                text: "Add Trips",
                iconActiveColor: Colors.blue,
                backgroundColor: Colors.blue.shade100,
                textColor: Colors.blue,
              ),
              GButton(
                haptic: true,
                iconColor: Colors.black,
                icon: Icons.favorite_border,
                text: "Favorite",
                iconActiveColor: Colors.pink,
                backgroundColor: Colors.pink.shade100,
                textColor: Colors.pink,
              ),
              GButton(
                haptic: true,
                iconColor: Colors.black,
                icon: Icons.person_outline,
                text: "Account",
                iconActiveColor: Colors.orange,
                backgroundColor: Colors.orange.shade100,
                textColor: Colors.orange,
              ),
            ]),
      ),
      // body: screen[selectedindex],
      body: PageView(
        controller: _pageController,
        children: screen,
        onPageChanged: (index) {
          setState(() {
            selectedindex = index;
          });
        },
      ),
    );
  }
}
