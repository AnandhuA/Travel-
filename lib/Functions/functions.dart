// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:travel/Models/model.dart';

List<HotPlaceModel> hotplacesList = [];
ValueNotifier<List<CategoriesModel>> categorieList = ValueNotifier([]);
ValueNotifier<List<PlaceModel>> placeList = ValueNotifier([]);

const categoryDbName = "category-database";
const placeDbName = "place-database";
const hotPlaceDbName = "hotPlace-database";

addHotPlaceDb({required List<HotPlaceModel> hotplace}) async {
  // final hotplaceBox = await Hive.openBox<HotPlaceModel>(hotPlaceDbName);
  // await hotplaceBox.put(key, value)
  // await Future.forEach(
  //     hotplace, (element) async => await hotplaceBox.put(element.id, element));
  hotplacesList.clear();
}

getHotPlace() async {
  final hotPlace = await Hive.openBox<HotPlaceModel>(hotPlaceDbName);
  final hot = hotPlace.values.toList();
  Future.forEach(hot, (element) => print(element.id));
}

addHotPlace({required HotPlaceModel hotplace}) {
  hotplacesList.add(HotPlaceModel(
      place: hotplace.place, image: hotplace.image, id: hotplace.id));

}

addCategories({required CategoriesModel categories}) async {
  final categorieBox = await Hive.openBox<CategoriesModel>(categoryDbName);
  await categorieBox.put(categories.id, categories);
}

Future<List<CategoriesModel>> getCategories() async {
  final categorieBox = await Hive.openBox<CategoriesModel>(categoryDbName);
  return categorieBox.values.toList();
}

addPlace({
  required PlaceModel place,
}) async {
  final placeModelBox = await Hive.openBox<PlaceModel>(placeDbName);
 
  await placeModelBox.put(place.id, place);
  hotplacesList.clear();
  refresh();
}

Future<List<PlaceModel>> getPlaces() async {
  final placesBox = await Hive.openBox<PlaceModel>(placeDbName);
  return placesBox.values.toList();
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
