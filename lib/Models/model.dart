class PlaceModel {
  final String place;
  final String image;
  final String district;
  final String discription;
  final String categories;

  PlaceModel(
      {required this.place,
      required this.image,
      required this.district,
      required this.discription,
      required this.categories});
}

class HotPlaceModel {
  final String place;
  final String image;

  HotPlaceModel({required this.place, required this.image});
}
