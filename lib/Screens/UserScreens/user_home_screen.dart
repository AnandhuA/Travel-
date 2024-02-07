import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travel/Screens/UserScreens/TabScreens/account_screen.dart';
import 'package:travel/Screens/UserScreens/TabScreens/AddTripScreens/add_trip_screen.dart';
import 'package:travel/Screens/UserScreens/TabScreens/explore_screen.dart';
import 'package:travel/Screens/UserScreens/TabScreens/favorite_screen.dart';
import 'package:travel/Screens/UserScreens/TabScreens/TripScreens/trip_screen.dart';
import 'package:travel/Widgets/drawer_wedget.dart';
import 'package:travel/Styles/colors.dart';

class UserHomeScreen extends StatefulWidget {
  final int index;
  const UserHomeScreen({super.key, required this.index});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  late int selectedindex;
  // final PageController _pageController = PageController();

  List<Widget> screen = [
    const ExploreScreen(),
    const MyTripsScreen(),
    const AddTripScreen(),
    const FavoriteScreen(),
    const AccountScreen()
  ];
  List<String> titles = ["", "My Trips", "Add Trip", "Favorite", "Account"];

  @override
  void initState() {
    selectedindex = widget.index;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedindex]),
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
          color: grey200,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
            onTabChange: (value) {
              setState(() {
                selectedindex = value;
                // _pageController.animateToPage(
                //   value,
                //   duration: const Duration(milliseconds: 50),
                //   curve: Curves.easeInOutCubicEmphasized,
                // );
              });
              // _pageController.jumpToPage(value);
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
                iconColor: black,
                icon: Icons.home_outlined,
                text: "Home",
                iconActiveColor: purple,
                backgroundColor: purple100,
                textColor: purple,
              ),
              GButton(
                haptic: true,
                iconColor: black,
                icon: Icons.category_outlined,
                text: "My Trips",
                iconActiveColor: green,
                backgroundColor: green100,
                textColor: green,
              ),
              GButton(
                haptic: true,
                iconColor: black,
                icon: Icons.add_circle_outline,
                text: "Add Trips",
                iconActiveColor: blue,
                backgroundColor: blue100,
                textColor: blue,
              ),
              GButton(
                haptic: true,
                iconColor: Colors.black,
                icon: Icons.favorite_border,
                text: "Favorite",
                iconActiveColor: pink,
                backgroundColor: pink100,
                textColor: pink,
              ),
              GButton(
                haptic: true,
                iconColor: black,
                icon: Icons.person_outline,
                text: "Account",
                iconActiveColor: orange,
                backgroundColor: orange100,
                textColor: orange,
              ),
            ]),
      ),
      // body: screen[selectedindex],
      body: AnimatedSwitcher(
        switchInCurve: Curves.easeInOutSine,
        duration: const Duration(milliseconds: 500),
        child: screen[selectedindex],
      ),
    );
  }
}
