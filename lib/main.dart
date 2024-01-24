import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel/Functions/admin_functions.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/admin_model.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Notifications/notification_initialization.dart';
import 'package:travel/Screens/AdminScreens/add_place_screen.dart';
import 'package:travel/Screens/AdminScreens/admin_home_screen.dart';
import 'package:travel/Screens/IntroScreens/intro_pages.dart';
import 'package:travel/Screens/StartScreens/splash_screen.dart';
import 'package:travel/Screens/UserScreens/add_travel_companions.dart';
import 'package:travel/Screens/UserScreens/user_home_screen.dart';
import 'package:travel/Screens/LoginAndSignupScreen/login_screen.dart';
import 'package:travel/Screens/LoginAndSignupScreen/signup_screen.dart';
import 'package:travel/firebase_options.dart';
import 'package:timezone/data/latest.dart' as tzdata;

late bool admin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  notificationInitialization();
   tzdata.initializeTimeZones();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(PlaceModelAdapter().typeId)) {
    Hive.registerAdapter(PlaceModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoriesModelAdapter().typeId)) {
    Hive.registerAdapter(CategoriesModelAdapter());
  }
  if (!Hive.isAdapterRegistered(FavoriteModelAdapter().typeId)) {
    Hive.registerAdapter(FavoriteModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TripModelAdapter().typeId)) {
    Hive.registerAdapter(TripModelAdapter());
  }
  if (!Hive.isAdapterRegistered(UserDetailsModelAdapter().typeId)) {
    Hive.registerAdapter(UserDetailsModelAdapter());
  }
  await refresh();
  await userRefresh();

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
        "Signup": (context) => const SignUpScreen(),
        "AdminHomePage": (context) => const AdminHomeScreen(),
        "AddPlace": (context) => const AddPlaceScreen(),
        "HomePage": (context) => const UserHomeScreen(),
        "IntroPage": (context) => const IntroScreen(),
        "AddCompanions":(context) => AddCompanionsScreen()
        //  "Animation": (context) =>  AnimationScreen(),
      },
    );
  }
}
