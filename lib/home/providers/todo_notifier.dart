import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../adapters/todo_hive.dart';

class TodoNotifier extends AsyncNotifier<List<TodoHive>>{
  final Box<TodoHive> _todoBox = Hive.box<TodoHive>('todo');
  @override
  Future<List<TodoHive>> build() async {
    return _getTodo();
  }

  Future<List<TodoHive>> _getTodo() async {
    final List<TodoHive> todoList = await _todoBox.values.toList();
    return todoList;
  }

  Future<void> addTodo(TodoHive todo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _todoBox.add(todo);
      return _getTodo();
    });
  }

  Future<void> removeTodo(String taskID) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final List<TodoHive> todoItems = _todoBox.values.toList();

      final existingItemIndex = todoItems.indexWhere((cartItem) => cartItem.taskID == taskID);
      if (existingItemIndex != -1) {
        final existingItem = todoItems[existingItemIndex];
        _todoBox.delete(existingItem.key);
      }
      return _getTodo();
    });
  }

  Future<void> prioritizeTodo(String taskID, bool isPrioritize) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final List<TodoHive> todoItems = _todoBox.values.toList();

      final existingItemIndex = todoItems.indexWhere((cartItem) => cartItem.taskID == taskID);
      if (existingItemIndex != -1) {
        final existingItem = todoItems[existingItemIndex];
        _todoBox.putAt(existingItem.key, existingItem.copyWith(isPrioritize: isPrioritize));
      }
      return _getTodo();
    });
  }
}