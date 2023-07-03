import 'package:app_to_do/home/providers/todo_provider.dart';
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

      final existingItemIndex = todoItems.indexWhere((taskItem) => taskItem.taskID == taskID);
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

      final existingItemIndex = todoItems.indexWhere((taskItem) => taskItem.taskID == taskID);
      if (existingItemIndex != -1) {
        final existingItem = todoItems[existingItemIndex];
        _todoBox.putAt(existingItem.key, existingItem.copyWith(isPrioritize: isPrioritize));
      }
      return _getTodo();
    });
  }
}

class PrioritizeTodoNotifier extends AsyncNotifier<List<TodoHive>> {
  @override
  Future<List<TodoHive>> build() async {
    return _getPrioritizeTodo();
  }

  Future<List<TodoHive>> _getPrioritizeTodo() async {
    final List<TodoHive> listPrioritizeTodo = [];
    final listTodo = ref.watch(todoNotifierProvider).value;
    if(listTodo != null) {
      for (var item in listTodo) {
        if (item.isPrioritize == true) {
          listPrioritizeTodo.add(item);
        }
      }
    }
    return await listPrioritizeTodo;
  }
}