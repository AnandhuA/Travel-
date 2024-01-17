import 'package:hive/hive.dart';
import 'package:travel/Models/admin_model.dart';
part 'user_model.g.dart';

@HiveType(typeId: 3)
class FavoriteModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final PlaceModel favoritePlace;

  FavoriteModel({required this.id, required this.favoritePlace});
}

@HiveType(typeId: 4)
class TripModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String destination;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String time;
  @HiveField(4)
  final DateTime rangeStart;
  @HiveField(5)
  final DateTime rangeEnd;

  TripModel(
      {required this.id,
      required this.destination,
      required this.description,
      required this.time,
      required this.rangeStart,
      required this.rangeEnd});
}
