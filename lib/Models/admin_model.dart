
class CategoriesModel {
  final String id;
  final String categorie;
  CategoriesModel({required this.id, required this.categorie});
}

class PlaceModel {
  final String id;
  final String place;
  final String district;
  final String description;
  final String categories;
  final List<String> image;

  PlaceModel({
    required this.id,
    required this.place,
    required this.district,
    required this.description,
    required this.categories,
    required this.image,
  });
}
