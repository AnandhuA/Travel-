import 'package:travel/Models/model.dart';

List<HotPlaceModel> hotplacesList = [];
List<String> categoriesList = [];
List<PlaceModel> placesList = [];

addHotPlace({required String place, required String image}) {
  hotplacesList.add(HotPlaceModel(place: place, image: image));
}

addCategories({required String categories}) {
  categoriesList.add(categories);
}

void addPlace({
  required String place,
  required String district,
  required String description,
  required String image,
  required List list,
  required String categorie
}) {
  placesList.add(PlaceModel(
      categories:  categorie,
      hotplace: list,
      place: place,
      image: image,
      district: district,
      description: description));
}
