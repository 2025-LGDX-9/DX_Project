// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energy_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnergyLogAdapter extends TypeAdapter<EnergyLog> {
  @override
  final int typeId = 12;

  @override
  EnergyLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnergyLog(
      deviceId: fields[0] as int,
      eventTime: fields[1] as DateTime,
      sourceType: fields[2] as String,
      extraInfo: fields[3] as String,
      powerState: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, EnergyLog obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.deviceId)
      ..writeByte(1)
      ..write(obj.eventTime)
      ..writeByte(2)
      ..write(obj.sourceType)
      ..writeByte(3)
      ..write(obj.extraInfo)
      ..writeByte(4)
      ..write(obj.powerState);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnergyLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
