import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'home/adapters/todo_hive.dart';
import 'home/providers/list_todo_provider.dart';
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
              tooltip: 'Ưu tiên',
              icon: const Icon(Icons.star),
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
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(selectedDate.year),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
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
                    _addToDoTask(nameController.text, noteController.text, selectedDate, selectedTime,  ref);
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

void _addToDoTask(String name, String note, DateTime date, TimeOfDay time, WidgetRef ref) async {
  var uuid = Uuid();
  String taskID = uuid.v4();
  String listTaskID = ref.read(tabNotifierProvider);

  DateTime combinedDateTime = DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
  int dateTimePick = combinedDateTime.millisecondsSinceEpoch;
  int dateTimeNow = DateTime.now().millisecondsSinceEpoch;
  if(dateTimePick < dateTimeNow){
    dateTimePick = 0;
  }

  TodoHive todo = TodoHive();
  todo.taskID = taskID;
  todo.taskName = name;
  todo.taskNote = note;
  todo.endTime = dateTimePick;
  todo.isPrioritize = false;
  todo.isCompleted = false;
  todo.listTaskID = listTaskID;

  await ref.read(todoNotifierProvider.notifier).addTodo(todo);
}