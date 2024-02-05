import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projects/todo/screen_todo.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('tasks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: Text('Список дел',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            )),
      ),
    );
  }
}

