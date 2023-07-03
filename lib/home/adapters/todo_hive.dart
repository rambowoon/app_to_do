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
  bool? isPrioritize;

  @HiveField(5)
  bool? isCompleted;

  @HiveField(6)
  String? listTaskID;


  TodoHive({this.taskID, this.taskName, this.taskNote, this.endTime, this.isPrioritize, this.isCompleted, this.listTaskID});

  TodoHive copyWith({String? taskID, String? taskName, String? taskNote, int? endTime, bool? isPrioritize, bool? isCompleted, String? listTaskID}){
    return TodoHive(
      taskID: taskID ?? this.taskID,
      taskName: taskName ?? this.taskName,
      taskNote: taskNote ?? this.taskNote,
      endTime: endTime ?? this.endTime,
      isPrioritize: isPrioritize ?? this.isPrioritize,
      isCompleted: isCompleted ?? this.isCompleted,
      listTaskID: listTaskID ?? this.listTaskID
    );
  }
}