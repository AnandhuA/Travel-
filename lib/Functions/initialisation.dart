import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel/FireBase/firebase_functions.dart';
import 'package:travel/FireBase/firebase_options.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Notifications/notification_initialization.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

initialisation() async {
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
  if (!Hive.isAdapterRegistered(CompletedTripModelPhotosAdapter().typeId)) {
    Hive.registerAdapter(CompletedTripModelPhotosAdapter());
  }
  if (!Hive.isAdapterRegistered(CompletedTripModelBlogAdapter().typeId)) {
    Hive.registerAdapter(CompletedTripModelBlogAdapter());
  }
  await getFireBaseDetails();
  await userRefresh();
  tripIteamsTolist();
  completedTripToList();
  blogToList();
}
