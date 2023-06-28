import 'package:flutter/material.dart';
import '../../constants.dart';
import '../adapters/todo_hive.dart';

class ToDoItem extends StatelessWidget {
  final TodoHive todo;

  const ToDoItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: ListTile(
              onTap: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              tileColor: kNormalColor,
              leading: Icon(
                todo.isCompleted ?? false ? Icons.check_box : Icons.check_box_outline_blank,
                color: kCompleteColor,
              ),
              title: Text(todo.taskName!),
              trailing: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  iconSize: 18,
                ),
              ),
            )
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}
