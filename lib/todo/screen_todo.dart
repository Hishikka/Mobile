import 'package:flutter/material.dart';
import 'package:projects/db/db.dart';
import 'package:projects/utils/dialog_box.dart';
import 'package:projects/utils/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final Widget title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myBox = Hive.box('tasks');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // Если открыли впервые приложение, то создаем начальные значения
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxClicked(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });

    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });

    Navigator.of(context).pop();

    db.updateDataBase();
  }

  void createTask() {
    _controller.clear();
    showDialog(
        context: context,
        builder: (context) {
          return MyDialogBox(
            controller: _controller,
            onSave: () => saveNewTask(),
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });

    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Align(alignment: Alignment.center, child: widget.title),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxClicked(value, index),
            onDelete: () => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
