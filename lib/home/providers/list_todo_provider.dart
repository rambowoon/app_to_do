import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../adapters/list_todo_hive.dart';
import 'list_todo_notifier.dart';

final listTodoNotifierProvider = AsyncNotifierProvider<ListTodoNotifier, List<ListTodoHive>>((){
  return ListTodoNotifier();
});

final tabNotifierProvider = NotifierProvider<TabNotifier, String>((){
  return TabNotifier();
});