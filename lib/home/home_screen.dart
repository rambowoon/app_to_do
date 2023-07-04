import 'package:uuid/uuid.dart';

import 'adapters/list_todo_hive.dart';
import 'providers/list_todo_provider.dart';
import 'providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'adapters/todo_hive.dart';
import 'widgets/todo_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listTodoProvider = ref.watch(listTodoNotifierProvider);
    List<ListTodoHive> listTab = [
      ListTodoHive(listTaskID: 'prioritize', listTaskName: ''),
      ListTodoHive(listTaskID: 'mytask', listTaskName: 'Việc cần làm của tôi')
    ];
    listTodoProvider.when(
        data: (todo) => {
          listTab.addAll(todo)
        },
        error: (err, stack) => Text('Lỗi rồi đại vương ơi'),
        loading: () => Center(child: CircularProgressIndicator.adaptive())
    );
    return DefaultTabController(
      initialIndex: 1,
      length: listTab.length + 1,
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
          bottom: TabBar(
            tabs: [
              for(ListTodoHive tab in listTab)
                tab.listTaskID == 'prioritize' ? Tab(icon: Icon(Icons.star_border)) : Tab(text: tab.listTaskName),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 5),
                    Text('Danh sách mới'),
                  ],
                )
              )
            ],
            isScrollable: true,
            onTap: (selectTab){
              if(selectTab < listTab.length){
                ref.read(tabNotifierProvider.notifier).changeTab(listTab[selectTab].listTaskID!);
                ref.read(todoTabNotifierProvider.notifier).getTodoInList();
              }
            },
          )
        ),
        body: TabBarView(
          children: [
            for(ListTodoHive tab in listTab)
              if(tab.listTaskID == 'prioritize')
                ListPrioritizeTodo()
              else
                ListTodo()
            ,
            ListTodoNew()
          ],
        ),
      ),
    );
  }
}

class ListPrioritizeTodo extends ConsumerWidget {
  const ListPrioritizeTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoPrioritizeNotifierProvider);

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
        error: (err, stack) => Text('Lỗi rồi đại vương ơi !'),
        loading: () => Center(child: CircularProgressIndicator.adaptive())
    );
  }
}

class ListTodo extends ConsumerWidget {
  const ListTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoTabNotifierProvider);

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
        error: (err, stack) => Text('Lỗi rồi đại vương ơi..'),
        loading: () => Center(child: CircularProgressIndicator.adaptive())
    );
  }
}

class ListTodoNew extends ConsumerWidget {
  const ListTodoNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();

    return Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Nhập tên danh sách',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey, // Màu của border
                  width: 1.0, // Độ dày của border
                ),
                borderRadius: BorderRadius.circular(8), // Bo góc của border
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue, // Màu border khi TextField được focus
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  _addListToDoTask(nameController.text, ref);
                  nameController.dispose();
                },
                child: Text('Thêm'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _addListToDoTask(String name, WidgetRef ref) async {
  var uuid = Uuid();
  var taskID = uuid.v4();
  ListTodoHive listTodoHive = ListTodoHive(
    listTaskID: taskID,
    listTaskName: name
  );
  await ref.read(listTodoNotifierProvider.notifier).addListTodo(listTodoHive);
}