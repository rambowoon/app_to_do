import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants.dart';
import '../adapters/todo_hive.dart';
import '../providers/todo_provider.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;


class ToDoItem extends ConsumerWidget {
  final TodoHive todo;

  const ToDoItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kNormalColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: (){
                  ref.read(todoNotifierProvider.notifier).prioritizeTodo(todo.taskID!, !todo.isPrioritize!);
                },
                icon: Icon(
                  todo.isPrioritize ?? false ? Icons.star : Icons.star_border,
                  color: kCompleteColor,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.taskName!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      todo.taskNote!,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 2),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        side: BorderSide(width: 1.0),
                        minimumSize: Size(80, 25),
                        padding: EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // Đặt giá trị radius tùy ý
                        ),
                        textStyle: TextStyle(fontSize: 11, color: Colors.deepPurple),
                      ),
                      child: Text(getRemainingTime(todo.endTime!)),
                    )
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, ref, todo.taskID!);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  iconSize: 18,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
void _showDeleteConfirmationDialog(BuildContext context,  WidgetRef ref, String taskID) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Xóa?'),
        content: Text('Bạn có chắc chắn muốn xóa?'),
        actions: <Widget>[
          TextButton(
            child: Text('Hủy'),
            onPressed: () {
              Navigator.of(context).pop(); // Đóng AlertDialog
            },
          ),
          TextButton(
            child: Text('Xóa'),
            onPressed: () {
              ref.read(todoNotifierProvider.notifier).removeTodo(taskID);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

String getRemainingTime(int timestamp) {
  final now = DateTime.now();
  final targetTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final remainingDuration = targetTime.difference(now);

  return timeago.format(now.subtract(remainingDuration));
}