import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToDo {
  String? id;
  String? work;
  String? time;
  bool isDone;

  ToDo({
    required this.id,
    required this.work,
    required this.time,
    this.isDone = false
  });

  // static List<ToDo> todoList(){
  //   return [
  //     ToDo(id: '1', work: 'Rửa chén', time: '2/4/2023 17:30', isDone: true),
  //     ToDo(id: '2', work: 'Giặt đồ', time: '2/4/2023 17:00'),
  //     ToDo(id: '3', work: 'Quét nhà', time: '2/4/2023 17:00', isDone: true),
  //     ToDo(id: '4', work: 'Học bài', time: '2/4/2023 19:00'),
  //     ToDo(id: '5', work: 'Đánh răng', time: '2/4/2023 09:30'),
  //     ToDo(id: '6', work: 'Đi ngủ', time: '2/4/2023 10:00'),
  //   ];
  // }
}

final todoList = [
  ToDo(id: '1', work: 'Rửa chén', time: '2/4/2023 17:30', isDone: true),
  ToDo(id: '2', work: 'Giặt đồ', time: '2/4/2023 17:00'),
  ToDo(id: '3', work: 'Quét nhà', time: '2/4/2023 17:00', isDone: true),
  ToDo(id: '4', work: 'Học bài', time: '2/4/2023 19:00'),
  ToDo(id: '5', work: 'Đánh răng', time: '2/4/2023 09:30'),
  ToDo(id: '6', work: 'Đi ngủ', time: '2/4/2023 10:00'),
  ToDo(id: '7', work: 'Dậy uống nước', time: '3/4/2023 02:00'),
];

final todoProvider = Provider<List<ToDo>>((ref) {
  return todoList;
});