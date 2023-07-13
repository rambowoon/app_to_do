import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import '../adapters/list_todo_hive.dart';
import 'list_todo_provider.dart';
import 'todo_provider.dart';

class ListTodoNotifier extends AsyncNotifier<List<ListTodoHive>>{
  final Box<ListTodoHive> _todoBox = Hive.box<ListTodoHive>('list_todo');

  @override
  Future<List<ListTodoHive>> build() async {
    return _getListTodo();
  }

  Future<List<ListTodoHive>> _getListTodo() async {
    final List<ListTodoHive> todoList = await _todoBox.values.toList();
    return todoList;
  }

  Future<void> loadTabListTodo(ListTodoHive todo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _todoBox.add(todo);
      return _getListTodo();
    });
  }

  Future<void> addListTodo(ListTodoHive todo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _todoBox.add(todo);
      ref.read(tabNotifierProvider.notifier).changeTab(todo.listTaskID!);
      ref.read(todoTabNotifierProvider.notifier).getTodoInList();
      return _getListTodo();
    });
  }

  Future<void> removeListTodo(String listTaskID) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final List<ListTodoHive> todoItems = _todoBox.values.toList();

      final existingItemIndex = todoItems.indexWhere((listTaskItem) => listTaskItem.listTaskID == listTaskID);
      if (existingItemIndex != -1) {
        final existingItem = todoItems[existingItemIndex];
        _todoBox.delete(existingItem.key);
      }
      return _getListTodo();
    });
  }
}

class TabNotifier extends Notifier<String> {
  @override
  String build() {
    state = 'mytask';
    return state;
  }
  void changeTab(String listTaskID) {
    state = listTaskID;
  }
}