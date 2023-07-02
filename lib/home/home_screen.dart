import 'providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'adapters/todo_hive.dart';
import 'widgets/todo_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.star_border)),
              Tab(text: 'Việc làm',),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          )
        ),
        body: TabBarView(
          children: [
            Icon(Icons.directions_transit),
            ListTodo(),
            Icon(Icons.directions_bike),
          ],
        ),

      ),
    );
  }
}

class ListTodo extends ConsumerWidget {
  const ListTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoNotifierProvider);

    return todoList.when(
        data: (todo) => ListView.builder(
          shrinkWrap: true,
          itemCount: todo?.length,
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          itemBuilder: (BuildContext context, int index) {
            final TodoHive todoItem = todo![index];
            return ToDoItem(todo: todoItem);
          }
        ),
        error: (err, stack) => Text('Lỗi rồi đại vương ơi'),
        loading: () => Center(child: CircularProgressIndicator.adaptive())
    );
  }
}