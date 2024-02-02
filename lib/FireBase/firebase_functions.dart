// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:travel/Models/admin_model.dart';

ValueNotifier<List<PlaceModel>> placeModelListener = ValueNotifier([]);

ValueNotifier<List<CategoriesModel>> categorieListener = ValueNotifier([]);

final FirebaseAuth _auth = FirebaseAuth.instance;
String userName = "No";
String userPhone = "NO";
String userEmail = "No";

class FirestroreService {
  final CollectionReference places =
      FirebaseFirestore.instance.collection("places");
  final CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");
  final CollectionReference user =
      FirebaseFirestore.instance.collection("Users");

  addPlace({
    required String place,
    required String district,
    required String description,
    required String categorie,
    required List<String> images,
  }) {
    places.add({
      "Place": place,
      "District": district,
      "Description": description,
      "Categories": categorie,
      "Images": images,
    });
    getFireBaseDetails();
  }

  updatePlace({
    required String id,
    required String place,
    required String district,
    required String description,
    required String categorie,
    required List<String> images,
  }) {
    places.doc(id).update({
      "Place": place,
      "District": district,
      "Description": description,
      "Categories": categorie,
      "Images": images,
    });
    getFireBaseDetails();
  }

  deletePlace({required String id}) {
    places.doc(id).delete();
    getFireBaseDetails();
  }

  getAllPlaces() async {
    try {
      QuerySnapshot querySnapshot = await places.get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<String> images = (data["Images"] as List<dynamic>).cast<String>();
        String documentId = doc.id;
        PlaceModel firebasePlaces = PlaceModel(
          id: documentId,
          place: data["Place"] ?? "no",
          district: data["District"] ?? "no",
          description: data["Description"] ?? "no",
          categories: data["Categories"] ?? "no",
          image: images,
        );

        placeModelListener.value.add(firebasePlaces);
      }
    } catch (error) {
      print('Error getting places from Firestore: $error');
    }
  }

  getAllCategories() async {
    try {
      QuerySnapshot querySnapshot = await categories.get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String documentId = doc.id;
        CategoriesModel firebaseCategories = CategoriesModel(
          id: documentId,
          categorie: data["Categorie"],
        );
        categorieListener.value.add(firebaseCategories);
      }
    } catch (e) {
      print("Error in categorie added $e");
    }
  }

  getUsers() async {
    try {
      QuerySnapshot querySnapshot = await user.get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        if (_auth.currentUser!.email == doc.id) {
          userName = doc["Name"];
          userPhone = doc["Phone"];
          userEmail = _auth.currentUser!.email ?? "No";
        }
      }
    } catch (e) {
      print(e);
    }
  }

  addCategories({required String categorie}) {
    categories.add({"Categorie": categorie});
    getFireBaseDetails();
  }

  editCategories({required CategoriesModel categoriesModel}) {
    categories
        .doc(categoriesModel.id)
        .update({"Categorie": categoriesModel.categorie});
    getFireBaseDetails();
  }

  deleteCategorie({required CategoriesModel categoriesModel}) {
    categories.doc(categoriesModel.id).delete();
    getFireBaseDetails();
  }
}

getFireBaseDetails() async {
  categorieListener.value.clear();
  placeModelListener.value.clear();
  final FirestroreService firestoreService = FirestroreService();
  firestoreService.getUsers();
  await firestoreService.getAllPlaces();
  await firestoreService.getAllCategories();
  placeModelListener.notifyListeners();
  categorieListener.notifyListeners();
}

