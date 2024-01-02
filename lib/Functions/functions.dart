// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:travel/Models/model.dart';

List<HotPlaceModel> hotplacesList = [];

ValueNotifier<List<CategoriesModel>> categorieList = ValueNotifier([]);
ValueNotifier<List<PlaceModel>> placeList = ValueNotifier([]);
// List<CategoriesModel> categoriesList = [];
// List<PlaceModel> placesList = [];

const categoryDbName = "category-database";
const placeDbName = "place-database";

addHotPlace({required String place, required String image}) {
  hotplacesList.add(HotPlaceModel(place: place, image: image));
}

addCategories({required CategoriesModel categories}) async {
  final categorie = await Hive.openBox<CategoriesModel>(categoryDbName);
  await categorie.put(categories.id, categories);
}

Future<List<CategoriesModel>> getCategories() async {
  final categorie = await Hive.openBox<CategoriesModel>(categoryDbName);
  return categorie.values.toList();
}

addPlace({
  required PlaceModel place,
}) async {
  final placeModelBox = await Hive.openBox<PlaceModel>(placeDbName);
  await placeModelBox.put(place.id, place);
  refresh();
}

Future<List<PlaceModel>> getPlaces() async {
  final places = await Hive.openBox<PlaceModel>(placeDbName);
  return places.values.toList();
}

delectPlace(String placeId) async {
  final place = await Hive.openBox<PlaceModel>(placeDbName);
  await place.delete(placeId);
  refresh();
}

refresh() async {
  final places = await getPlaces();
  final categorie = await getCategories();
  placeList.value.clear();
  categorieList.value.clear();
  await Future.forEach(places, (PlaceModel placeModel) {
    placeList.value.add(placeModel);
  });
  await Future.forEach(categorie, (CategoriesModel categoriesModel) {
    categorieList.value.add(categoriesModel);
  });
  categorieList.notifyListeners();
  placeList.notifyListeners();
}
