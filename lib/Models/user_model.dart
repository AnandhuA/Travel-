import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel/Models/admin_model.dart';
part 'user_model.g.dart';

@HiveType(typeId: 3)
class FavoriteModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final PlaceModel favoritePlace;
  @HiveField(2)
  final String uid;

  FavoriteModel(
      {required this.id, required this.favoritePlace, required this.uid});
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
  @HiveField(6)
  final String uid;

  TripModel(
      {required this.id,
      required this.destination,
      required this.description,
      required this.time,
      required this.rangeStart,
      required this.rangeEnd,
      required this.uid});
}

@HiveType(typeId: 5)
class UserDetailsModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String? photo;

  UserDetailsModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      this.photo});
}
