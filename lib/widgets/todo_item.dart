import 'package:app_to_do/model/todo.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;

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
                todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
                color: kCompleteColor,
              ),
              title: Text(todo.work!),
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
