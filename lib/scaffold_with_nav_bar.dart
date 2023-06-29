import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'home/adapters/todo_hive.dart';
import 'home/providers/todo_provider.dart';

class ScaffoldWithNavBar extends ConsumerWidget {
  const ScaffoldWithNavBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showBottomSheet(context, ref);
        },
        tooltip: 'Add New Item',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 80.0,
      child: BottomAppBar(
        color: Colors.deepPurple,
        elevation: null,
        child: Row(
          children: <Widget>[
            IconButton(
              color: Colors.white,
              tooltip: 'Open popup menu',
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                final SnackBar snackBar = SnackBar(
                  content: const Text('Yay! A SnackBar!'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            IconButton(
              color: Colors.white,
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              color: Colors.white,
              tooltip: 'Favorite',
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, WidgetRef ref) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
        selectedTime = pickedTime;
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {

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
            Text(
              'Thêm công việc cần làm',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Nhập tên công việc',
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: noteController,
              decoration: InputDecoration(
                hintText: 'Ghi chú',
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.calendar_month),
                      onPressed: (){
                        _selectDate();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: (){
                        _selectTime();
                      },
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {
                    _addToDoTask(nameController.text, noteController.text, ref);
                    Navigator.pop(context);
                  },
                  child: Text('Thêm'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}



void _addToDoTask(String name, String note, WidgetRef ref) async {
  var uuid = Uuid();
  var taskID = uuid.v4();
  print(taskID);
  TodoHive todo = TodoHive();
  todo.taskID = taskID;
  todo.taskName = name;
  todo.taskNote = note;
  todo.endTime = 1688049190;
  todo.isCompleted = false;

  await ref.read(todoNotifierProvider.notifier).addTodo(todo);
}