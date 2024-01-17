import 'package:hive/hive.dart';
part 'admin_model.g.dart';

@HiveType(typeId: 1)
class PlaceModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String place;
  @HiveField(2)
  final List<String> image;
  @HiveField(3)
  final String district;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final CategoriesModel categories;
  @HiveField(6)
  final List<Map> hotplace;

  PlaceModel({
    required this.id,
    required this.hotplace,
    required this.place,
    required this.image,
    required this.district,
    required this.description,
    required this.categories,
  });
    PlaceModel updateModel({
    String? id,
    List<Map>? hotplace,
    String? place,
    List<String>? image,
    String? district,
    String? description,
    CategoriesModel? categories,
  }) {
    return PlaceModel(
      id: id ?? this.id,
      hotplace: hotplace ?? this.hotplace,
      place: place ?? this.place,
      image: image ?? this.image,
      district: district ?? this.district,
      description: description ?? this.description,
      categories: categories ?? this.categories,
    );
  }

}


@HiveType(typeId: 2)
class CategoriesModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String categorie;

  CategoriesModel({required this.id, required this.categorie});
}
