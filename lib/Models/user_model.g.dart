// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackingListModelAdapter extends TypeAdapter<PackingListModel> {
  @override
  final int typeId = 2;

  @override
  PackingListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PackingListModel(
      id: fields[0] as String,
      item: fields[1] as String,
      tripId: fields[2] as int,
      check: fields[3] as bool,
      quantity: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PackingListModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.item)
      ..writeByte(2)
      ..write(obj.tripId)
      ..writeByte(3)
      ..write(obj.check)
      ..writeByte(4)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackingListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavoriteModelAdapter extends TypeAdapter<FavoriteModel> {
  @override
  final int typeId = 3;

  @override
  FavoriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteModel(
      id: fields[0] as String,
      favoritePlace: fields[1] as String,
      uid: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.favoritePlace)
      ..writeByte(2)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TripModelAdapter extends TypeAdapter<TripModel> {
  @override
  final int typeId = 4;

  @override
  TripModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripModel(
      id: fields[0] as int,
      destination: fields[1] as String,
      description: fields[2] as String,
      time: fields[3] as String,
      rangeStart: fields[4] as DateTime,
      rangeEnd: fields[5] as DateTime,
      uid: fields[6] as String,
      travelType: fields[7] as String,
      numberOfPeople: fields[8] as int,
      budget: fields[9] as int,
      activitys: (fields[10] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
      notification: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TripModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.destination)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.rangeStart)
      ..writeByte(5)
      ..write(obj.rangeEnd)
      ..writeByte(6)
      ..write(obj.uid)
      ..writeByte(7)
      ..write(obj.travelType)
      ..writeByte(8)
      ..write(obj.numberOfPeople)
      ..writeByte(9)
      ..write(obj.budget)
      ..writeByte(10)
      ..write(obj.activitys)
      ..writeByte(11)
      ..write(obj.notification);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
