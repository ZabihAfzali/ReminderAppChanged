// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminders_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddEventModelAdapter extends TypeAdapter<AddEventModel> {
  @override
  final int typeId = 0;

  @override
  AddEventModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddEventModel(
      eventName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddEventModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.eventName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddEventModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RemindersModelAdapter extends TypeAdapter<RemindersModel> {
  @override
  final int typeId = 1;

  @override
  RemindersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RemindersModel(
      eventName: fields[0] as String,
      description: fields[1] as String,
      date: fields[2] as String,
      time: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RemindersModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.eventName)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemindersModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
