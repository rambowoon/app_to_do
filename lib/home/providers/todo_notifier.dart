import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../adapters/todo_hive.dart';

class TodoNotifier extends AsyncNotifier<List<TodoHive>>{

  @override
  Future<List<TodoHive>> build() async {
    return _getTodo();
  }

  Future<List<TodoHive>> _getTodo() async {
    final Box<TodoHive> _todoBox = Hive.box<TodoHive>('todo');
    final List<TodoHive> todoList = await _todoBox.values.toList();

    return todoList;
  }

  Future<void> addTodo(TodoHive todo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final Box<TodoHive> box = Hive.box<TodoHive>('todo');
      await box.add(todo);
      return _getTodo();
    });
  }
}