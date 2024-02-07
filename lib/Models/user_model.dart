import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 2)
class PackingListModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String item;
  @HiveField(2)
  final int tripId;
  @HiveField(3)
  final bool check;
  @HiveField(4)
  final String quantity;


  PackingListModel({
    required this.id,
    required this.item,
    required this.tripId,
    required this.check,
    required this.quantity,
  });
}

@HiveType(typeId: 3)
class FavoriteModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String favoritePlace;
  @HiveField(2)
  final String uid;

  FavoriteModel({
    required this.id,
    required this.favoritePlace,
    required this.uid,
  });
}

@HiveType(typeId: 4)
class TripModel {
  @HiveField(0)
  final int id;
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
  @HiveField(7)
  final String travelType;
  @HiveField(8)
  final int numberOfPeople;
  @HiveField(9)
  final int budget;
  @HiveField(10)
  final Map<String, List<String>> activitys;
  @HiveField(11)
  final bool notification;

  TripModel({
    required this.id,
    required this.destination,
    required this.description,
    required this.time,
    required this.rangeStart,
    required this.rangeEnd,
    required this.uid,
    required this.travelType,
    required this.numberOfPeople,
    required this.budget,
    required this.activitys,
    required this.notification,
  });
}
