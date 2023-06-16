// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_events_model.dart';

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
