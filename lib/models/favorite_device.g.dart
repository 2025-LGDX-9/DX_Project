// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_device.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteDeviceAdapter extends TypeAdapter<FavoriteDevice> {
  @override
  final int typeId = 0;

  @override
  FavoriteDevice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteDevice(
      name: fields[0] as String,
      iconCode: fields[1] as int,
      type: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteDevice obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.iconCode)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteDeviceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
