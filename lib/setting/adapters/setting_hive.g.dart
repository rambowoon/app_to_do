// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingHiveAdapter extends TypeAdapter<SettingHive> {
  @override
  final int typeId = 1;

  @override
  SettingHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingHive(
      themeMode: fields[0] as String?,
      language: fields[1] as String?,
      splash: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.themeMode)
      ..writeByte(1)
      ..write(obj.language)
      ..writeByte(2)
      ..write(obj.splash);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
