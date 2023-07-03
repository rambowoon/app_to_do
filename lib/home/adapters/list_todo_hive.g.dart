// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_todo_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListTodoHiveAdapter extends TypeAdapter<ListTodoHive> {
  @override
  final int typeId = 3;

  @override
  ListTodoHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListTodoHive(
      listTaskID: fields[0] as String?,
      listTaskName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ListTodoHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.listTaskID)
      ..writeByte(1)
      ..write(obj.listTaskName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListTodoHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
