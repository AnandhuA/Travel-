import 'package:flutter/material.dart';
import 'package:travel/Functions/initialisation.dart';
import 'package:travel/Screens/AdminScreens/add_place_screen.dart';
import 'package:travel/Screens/AdminScreens/admin_home_screen.dart';
import 'package:travel/Screens/IntroScreens/intro_pages.dart';
import 'package:travel/Screens/StartScreens/splash_screen.dart';
import 'package:travel/Screens/UserScreens/TabScreens/AddTripScreens/add_travel_companions.dart';
import 'package:travel/Screens/UserScreens/TabScreens/AddTripScreens/add_trip_plan.dart';
import 'package:travel/Screens/UserScreens/user_home_screen.dart';
import 'package:travel/Screens/LoginAndSignupScreen/login_screen.dart';
import 'package:travel/Screens/LoginAndSignupScreen/signup_screen.dart';

late bool admin;

void main() async {
  await initialisation();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        "Login": (context) => const LoginScreen(),
        "SigUp": (context) => const SignUpScreen(),
        "AdminHomePage": (context) => const AdminHomeScreen(),
        "AddPlace": (context) => const AddPlaceScreen(),
        "HomePage": (context) => const UserHomeScreen(index: 0),
        "IntroPage": (context) => const IntroScreen(),
        "AddCompanions": (context) => const AddCompanionsScreen(),
        "AddTripPlan": (context) => const AddTripPlan()
      },
    );
  }
}
