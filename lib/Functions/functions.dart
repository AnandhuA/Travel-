// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:travel/Models/model.dart';

Map<String, String> hotplacesListMap = {};
ValueNotifier<List<CategoriesModel>> categorieList = ValueNotifier([]);
ValueNotifier<List<PlaceModel>> placeList = ValueNotifier([]);

const categoryDbName = "category-database";
const placeDbName = "place-database";
const hotPlaceDbName = "hotPlace-database";

addCategories({required CategoriesModel categories}) async {
  final categorieBox = await Hive.openBox<CategoriesModel>(categoryDbName);
  await categorieBox.put(categories.id, categories);
  refresh();
}

deleteCategorie({required CategoriesModel categories}) async {
  final categorieBox = await Hive.openBox<CategoriesModel>(categoryDbName);
  await categorieBox.delete(categories.id);
  refresh();
}

Future<List<CategoriesModel>> getCategories() async {
  final categorieBox = await Hive.openBox<CategoriesModel>(categoryDbName);
  return categorieBox.values.toList();
}

Future<List<PlaceModel>> getPlaces() async {
  final placesBox = await Hive.openBox<PlaceModel>(placeDbName);
  return placesBox.values.toList();
}

addPlace({
  required PlaceModel place,
}) async {
  final placeModelBox = await Hive.openBox<PlaceModel>(placeDbName);
  await placeModelBox.put(place.id, place);
  refresh();
}

updatePlace({required PlaceModel place}) async {
  final placeModelBox = await Hive.openBox<PlaceModel>(placeDbName);
  await placeModelBox.put(place.id, place);
}

deletePlace(String placeId) async {
  final placeBox = await Hive.openBox<PlaceModel>(placeDbName);
  await placeBox.delete(placeId);
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
