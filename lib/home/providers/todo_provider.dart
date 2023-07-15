import 'package:app_to_do/home/providers/todo_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../adapters/todo_hive.dart';

final todoNotifierProvider = AsyncNotifierProvider<TodoNotifier, List<TodoHive>>((){
  return TodoNotifier();
});