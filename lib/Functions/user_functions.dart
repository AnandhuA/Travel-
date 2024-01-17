// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel/Models/user_model.dart';

const favoriteDbName = "favorite-database";
const tripDbName = "trip-database";
ValueNotifier<List<FavoriteModel>> favoriteList = ValueNotifier([]);
ValueNotifier<List<TripModel>> tripList = ValueNotifier([]);
ValueNotifier<List<TripModel>> tripListCompleted = ValueNotifier([]);
// ValueNotifier<List<TripModel>> tripListNow = ValueNotifier([]);

addFavorite({required FavoriteModel favoritePlace}) async {
  final favoriteBox = await Hive.openBox<FavoriteModel>(favoriteDbName);
  favoriteBox.put(favoritePlace.id, favoritePlace);
  userRefresh();
}

removeFavorite({required FavoriteModel favoritePlace}) async {
  final favoriteBox = await Hive.openBox<FavoriteModel>(favoriteDbName);
  await favoriteBox.delete(favoritePlace.id);
  await userRefresh();
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
  final favorite = await getFavorite();
  final trip = await getTrip();
  favoriteList.value.clear();
  tripList.value.clear();
  tripListCompleted.value.clear();
  // tripListNow.value.clear();
  favoriteList.value = List.from(favorite);
  for (var element in trip) {
    DateTime rangeEnd = element.rangeEnd;
    // DateTime rangeStart = element.rangeStart;
    DateTime now = DateTime.now();
    if (rangeEnd.isBefore(now)) {
      tripListCompleted.value.add(element);
    }
    //  else if (rangeStart.isBefore(now) && rangeEnd.isAfter(now)) {
    //   tripListNow.value.add(element);
    // }
    else {
      tripList.value.add(element);
    }
  }
  tripList.value
      .sort((first, second) => first.rangeStart.compareTo(second.rangeStart));
  tripListCompleted.value
      .sort((first, second) => second.rangeStart.compareTo(first.rangeStart));
  tripList.notifyListeners();
  favoriteList.notifyListeners();
  tripListCompleted.notifyListeners();
  // tripListNow.notifyListeners();
}
