import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class PlaceModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String place;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String district;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final String categories;
  @HiveField(6)
  final List<HotPlaceModel> hotplace;

  PlaceModel({
    required this.id,
    required this.hotplace,
    required this.place,
    required this.image,
    required this.district,
    required this.description,
    required this.categories,
  });
}

@HiveType(typeId: 2)
class CategoriesModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String categorie;

  CategoriesModel({required this.id, required this.categorie});
}

class HotPlaceModel {
  final String place;
  final String image;

  HotPlaceModel({required this.place, required this.image});
}
