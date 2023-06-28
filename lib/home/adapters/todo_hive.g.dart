// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoHiveAdapter extends TypeAdapter<TodoHive> {
  @override
  final int typeId = 2;

  @override
  TodoHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoHive(
      taskID: fields[0] as int?,
      taskName: fields[1] as String?,
      taskNote: fields[2] as String?,
      endTime: fields[3] as int?,
      isCompleted: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, TodoHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.taskID)
      ..writeByte(1)
      ..write(obj.taskName)
      ..writeByte(2)
      ..write(obj.taskNote)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
