import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel/Screens/AdminScreens/add_place_screen.dart';
import 'package:travel/Screens/AdminScreens/admin_home_screen.dart';
import 'package:travel/Screens/login_screen.dart';
import 'package:travel/Screens/signup_screen.dart';
import 'package:travel/Screens/splash_screen.dart';
import 'package:travel/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        "Login": (context) => const LoginScreen(),
        "Signup": (context) => const SignUpScreen(),
        "HomePage": (context) => const AdminHomeScreen(),
        "AddPlace": (context) => AddPlaceScreen(),
        // "PlaceDetails":(context) => const PlaceDetailsScreen()
      },
    );
  }
}
