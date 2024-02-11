import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class ExpensesModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int tripId;
  @HiveField(2)
  final String amount;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final Color color;
  @HiveField(5)
  final IconData icon;
  @HiveField(6)
  final String category;
  @HiveField(7)
  final DateTime date;

  ExpensesModel({
    required this.id,
    required this.tripId,
    required this.amount,
    this.description,
    required this.color,
    required this.icon,
    required this.category,
    required this.date,
  });
}

@HiveType(typeId: 2)
class PackingListModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String item;
  @HiveField(2)
  final int tripId;
  @HiveField(3)
  bool check;
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

class ColorAdapter extends TypeAdapter<Color> {
  @override
  final typeId = 5;

  @override
  Color read(BinaryReader reader) {
    final colorValue = reader.readInt();
    return Color(colorValue);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeInt(obj.value);
  }
}

class IconDataAdapter extends TypeAdapter<IconData> {
  @override
  final typeId = 6;
  @override
  IconData read(BinaryReader reader) {
    final iconCode = reader.readInt();
    return IconData(iconCode, fontFamily: 'MaterialIcons');
  }

  @override
  void write(BinaryWriter writer, IconData obj) {
    writer.writeInt(obj.codePoint);
  }
}

@HiveType(typeId: 7)
class CompletedTripModelPhotos {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String photos;
  @HiveField(2)
  final int tripId;
  CompletedTripModelPhotos({
    required this.id,
    required this.photos,
    required this.tripId,
  });
}

@HiveType(typeId: 8)
class CompletedTripModelBlog {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String blog;
  @HiveField(2)
  final int tripId;

  CompletedTripModelBlog({
    required this.id,
    required this.blog,
    required this.tripId,
  });
}
