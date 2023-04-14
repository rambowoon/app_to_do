import 'package:app_to_do/widgets/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants.dart';
import '../model/todo.dart';

class HomeScreen extends ConsumerStatefulWidget  {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  bool isChecked = false;
  int _selectedIndex = 0;
  final ScrollController _homeController = ScrollController();

  void initState() {
    super.initState();
    ref.read(todoProvider);
  }

  @override
  Widget build(BuildContext context) {
    final todoList = ref.watch(todoProvider);
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: ListView(
          controller: _homeController,
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          children: [
            for (ToDo todo in todoList)
              ToDoItem(todo: todo),
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.blueGrey,), label: 'Trang chủ', activeIcon: Icon(Icons.home, color: Colors.deepPurple,)),
          BottomNavigationBarItem(icon: Icon(Icons.add_alarm_outlined, color: Colors.blueGrey,), label: 'Chưa làm', activeIcon: Icon(Icons.add_alarm_outlined, color: Colors.deepPurple,)),
          BottomNavigationBarItem(icon: Icon(Icons.access_alarm, color: Colors.blueGrey,), label: 'Đã làm', activeIcon: Icon(Icons.access_alarm, color: Colors.deepPurple,)),
          BottomNavigationBarItem(icon: Icon(Icons.add, color: Colors.blueGrey,), label: 'Thêm mới', activeIcon: Icon(Icons.add, color: Colors.deepPurple,))
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: (int index) async {
          switch (index) {
            case 0:
            // only scroll to top when current index is selected.
              if (_selectedIndex == index) {
                _homeController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              }
              break;
            case 3:
              final data = await showDialog(context: context, builder: (_) => const FormAddToDo());

              break;
          }
          setState(
                () {
              _selectedIndex = index;
            },
          );
        },
      )
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: kBackgroundColor,
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
    );
  }
}

class FormAddToDo extends StatefulWidget {
  const FormAddToDo({Key? key}) : super(key: key);

  @override
  State<FormAddToDo> createState() => _FormAddToDoState();
}

class _FormAddToDoState extends State<FormAddToDo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm công việc cần làm'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
                hintText: 'Nhập tên công việc'
            ),
          ),
          const SizedBox(height: 12,),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
                hintText: 'Ghi chu'
            ),
          ),
        ],
      ),
      actions: <TextButton>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
        TextButton(onPressed: (){
          final String name = _nameController.text;
          final String note = _noteController.text;
          Navigator.pop(context, {'name':name, 'note':note});
        }, child: Text('Thêm'))
      ],

    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _noteController.dispose();
  }
}