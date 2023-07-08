// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dateFormat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DateFormatModelAdapter extends TypeAdapter<DateFormatModel> {
  @override
  final int typeId = 2;

  @override
  DateFormatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DateFormatModel(
      dateFormat: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DateFormatModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.dateFormat);
  }
  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateFormatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
