import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../setting_language.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  const ScaffoldWithNavBar({super.key, required this.child});

  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showBottomSheet(context);
        },
        tooltip: 'Add New Item',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _noteController.dispose();
  }
}


class CustomBottomNavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      final TextEditingController nameController = TextEditingController();
      final TextEditingController noteController = TextEditingController();

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
                Icon(Icons.access_time),
                TextButton(
                  onPressed: () {
                    _addToDoTask(nameController.text, noteController.text);
                    Navigator.pop(context);
                    nameController.dispose();
                    noteController.dispose();
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

void _addToDoTask(String name, String note) {
  // Thực hiện hành động khi nhấn nút Thêm và sử dụng giá trị của các trường nhập liệu
  print('Tên công việc: $name');
  print('Ghi chú: $note');
}