// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel/FireBase/firebase_functions.dart';
import 'package:travel/Models/admin_model.dart';
import 'package:travel/Models/user_model.dart';

const favoriteDbName = "favorite-database";
const tripDbName = "trip-database";
const userDbName = "user-database";

ValueNotifier<List<PlaceModel>> favplace = ValueNotifier([]);
ValueNotifier<List<TripModel>> tripList = ValueNotifier([]);
ValueNotifier<List<TripModel>> tripListCompleted = ValueNotifier([]);

addFavorite({required FavoriteModel favoritePlace}) async {
  final favoriteBox = await Hive.openBox<FavoriteModel>(favoriteDbName);
  favoriteBox.put(favoritePlace.id, favoritePlace);
  userRefresh();
  // findFav();
}

removeFavorite({required String favoritePlace}) async {
  final favoriteBox = await Hive.openBox<FavoriteModel>(favoriteDbName);
  await favoriteBox.delete(favoritePlace);
  await userRefresh();
  // findFav();
}

Future<List<FavoriteModel>> getFavorite() async {
  final favoriteBox = await Hive.openBox<FavoriteModel>(favoriteDbName);
  return favoriteBox.values.toList();
}

addTrip({required TripModel trip}) async {
  final tripBox = await Hive.openBox<TripModel>(tripDbName);
  await tripBox.put(trip.id, trip);
  userRefresh();
}

deleteTrip({required TripModel trip}) async {
  final tripbox = await Hive.openBox<TripModel>(tripDbName);
  await tripbox.delete(trip.id);
  userRefresh();
}

Future<List<TripModel>> getTrip() async {
  final tripBox = await Hive.openBox<TripModel>(tripDbName);
  return tripBox.values.toList();
}

userRefresh() async {
  // await getUser();
  favplace.value.clear();
  final favorite = await getFavorite();
  final trip = await getTrip();
  tripList.value.clear();
  // userData.clear();
  tripListCompleted.value.clear();
  // userData = List.from(user);

  Future.forEach(favorite, (element) {
    if (FirebaseAuth.instance.currentUser != null) {
      if (element.uid == FirebaseAuth.instance.currentUser!.uid.toString()) {
        for (PlaceModel place in placeModelListener.value) {
          if (element.favoritePlace == place.id) {
            favplace.value.add(place);
          }
        }
      }
    }
  });

  for (var element in trip) {
    DateTime rangeEnd = element.rangeEnd;
    DateTime now = DateTime.now();
    if (FirebaseAuth.instance.currentUser != null) {
      if (element.uid == FirebaseAuth.instance.currentUser!.uid.toString()) {
        if (rangeEnd.isBefore(now)) {
          tripListCompleted.value.add(element);
        } else {
          tripList.value.add(element);
        }
      }
    }
  }

  tripList.value
      .sort((first, second) => first.rangeStart.compareTo(second.rangeStart));
  tripListCompleted.value
      .sort((first, second) => second.rangeStart.compareTo(first.rangeStart));
  tripList.notifyListeners();
  favplace.notifyListeners();
  tripListCompleted.notifyListeners();
}

DateTime convertDateTime({required TripModel trip}) {
  String time = trip.time;
  List<String> parts = time.split(":");
  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1].split(" ")[0]);
  String amPm = parts[1].split(" ")[1];

  if (hours != 0) {
    int adjustedHour = amPm == "AM" ? hours % 12 : (hours % 12) + 12;
    return DateTime(
      trip.rangeStart.year,
      trip.rangeStart.month,
      trip.rangeStart.day,
      adjustedHour,
      minutes,
    );
  } else {
    return DateTime.now();
  }
}
