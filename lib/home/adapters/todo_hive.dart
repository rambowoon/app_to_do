import 'package:hive/hive.dart';

part 'todo_hive.g.dart';

@HiveType(typeId: 2)
class TodoHive extends HiveObject {
  @HiveField(0)
  String? taskID;

  @HiveField(1)
  String? taskName;

  @HiveField(2)
  String? taskNote;

  @HiveField(3)
  int? endTime;

  @HiveField(4)
  bool? isCompleted;

  TodoHive({this.taskID, this.taskName, this.taskNote, this.endTime, this.isCompleted});
}