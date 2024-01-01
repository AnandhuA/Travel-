import 'package:travel/Models/model.dart';

List<HotPlaceModel> hotplacesList = [];
List<PlaceModel> placesList = [];

addHotPlace({required String place, required String image}) {
 hotplacesList.add(HotPlaceModel(place: place, image: image));
}

void addPlace({
  required String place,
  required String district,
  required String description,
  required String image,
  required List list ,
}) {
  placesList.add(PlaceModel(
      hotplace: list,
      place: place,
      image: image,
      district: district,
      description: description));
}
