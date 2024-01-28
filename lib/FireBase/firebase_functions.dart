import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel/Models/admin_model.dart';

List<PlaceModel> firebasePlaceModelList = [];
List<CategoriesModel> categorieList = [];

class FirestroreService {
  final CollectionReference places =
      FirebaseFirestore.instance.collection("places");
  final CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");

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
  }

  deletePlace({required String id}) {
    places.doc(id).delete();
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

        firebasePlaceModelList.add(firebasePlaces);
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
        categorieList.add(firebaseCategories);
      }
    } catch (e) {
      print("Error in categorie added $e");
    }
  }

  addCategories({required String categorie}) {
    categories.add({"Categorie": categorie});
  }

  editCategories({required CategoriesModel categoriesModel}) {
    categories
        .doc(categoriesModel.id)
        .update({"Categorie": categoriesModel.categorie});
  }

  deleteCategorie({required CategoriesModel categoriesModel}) {
    categories.doc(categoriesModel.id).delete();
  }
}

getFireBaseDetails() async {
  final FirestroreService firestoreService = FirestroreService();
  await firestoreService.getAllPlaces();
  await firestoreService.getAllCategories();
}
