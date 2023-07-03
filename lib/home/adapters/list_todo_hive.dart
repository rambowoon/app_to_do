import 'package:hive/hive.dart';

part 'list_todo_hive.g.dart';

@HiveType(typeId: 3)
class ListTodoHive extends HiveObject {
  @HiveField(0)
  String? listTaskID;

  @HiveField(1)
  String? listTaskName;


  ListTodoHive({this.listTaskID, this.listTaskName});
}