class PlaceModel {
  final String place;
  final String image;
  final String district;
  final String description;
  // final String categories;
  List hotplace = [];

  PlaceModel({
    required this.hotplace,
    required this.place,
    required this.image,
    required this.district,
    required this.description,
    // required this.categories,
  });
}

class HotPlaceModel {
  final String place;
  final String image;

  HotPlaceModel({required this.place, required this.image});
}
