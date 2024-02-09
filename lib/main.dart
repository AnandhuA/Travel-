import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel/FireBase/firebase_functions.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Notifications/notification_initialization.dart';
import 'package:travel/Screens/AdminScreens/add_place_screen.dart';
import 'package:travel/Screens/AdminScreens/admin_home_screen.dart';
import 'package:travel/Screens/IntroScreens/intro_pages.dart';
import 'package:travel/Screens/StartScreens/splash_screen.dart';
import 'package:travel/Screens/UserScreens/TabScreens/AddTripScreens/add_travel_companions.dart';
import 'package:travel/Screens/UserScreens/TabScreens/AddTripScreens/add_trip_plan.dart';
import 'package:travel/Screens/UserScreens/user_home_screen.dart';
import 'package:travel/Screens/LoginAndSignupScreen/login_screen.dart';
import 'package:travel/Screens/LoginAndSignupScreen/signup_screen.dart';
import 'package:travel/FireBase/firebase_options.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

late bool admin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await notificationInitialization();
  tzdata.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(FavoriteModelAdapter().typeId)) {
    Hive.registerAdapter(FavoriteModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TripModelAdapter().typeId)) {
    Hive.registerAdapter(TripModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PackingListModelAdapter().typeId)) {
    Hive.registerAdapter(PackingListModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ExpensesModelAdapter().typeId)) {
    Hive.registerAdapter(ExpensesModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ColorAdapter().typeId)) {
    Hive.registerAdapter(ColorAdapter());
  }
  if (!Hive.isAdapterRegistered(IconDataAdapter().typeId)) {
    Hive.registerAdapter(IconDataAdapter());
  }

  await getFireBaseDetails();
  await userRefresh();
  tripIteamsTolist();

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
        "HomePage": (context) => const UserHomeScreen(
              index: 0,
            ),
        "IntroPage": (context) => const IntroScreen(),
        "AddCompanions": (context) => const AddCompanionsScreen(),
        "AddTripPlan": (context) => const AddTripPlan()
        //  "Animation": (context) =>  AnimationScreen(),
      },
    );
  }
}
