import 'package:app_to_do/home/providers/todo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../adapters/todo_hive.dart';
import 'list_todo_provider.dart';

class TodoNotifier extends AsyncNotifier<List<TodoHive>>{
  final Box<TodoHive> _todoBox = Hive.box<TodoHive>('todo');

  @override
  Future<List<TodoHive>> build() async {
    return _getTodo();
  }

  Future<List<TodoHive>> _getTodo() async {
    final tabActive = ref.read(tabNotifierProvider);
    final List<TodoHive> listTodo = await _todoBox.values.toList();
    final List<TodoHive> result = [];
    if(tabActive == 'prioritize') {
      if(listTodo != null) {
        for (TodoHive item in listTodo) {
          if (item.isPrioritize == true) {
            result.add(item);
          }
        }
      }
    }else{
      if (listTodo != null) {
        for (TodoHive todo in listTodo) {
          if (todo.listTaskID == tabActive!) {
            result.add(todo);
          }
        }
      }
    }
    return await result;
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
        await _todoBox.delete(existingItem.key);
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
        await _todoBox.putAt(existingItem.key, existingItem.copyWith(isPrioritize: isPrioritize));
      }
      return _getTodo();
    });
  }

  Future<void> getTodoInList() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _getTodo();
    });
  }
}