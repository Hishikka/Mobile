import 'package:flutter/material.dart';
import 'package:projects/news/screen_news.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'news',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: Text('Новости',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            )),
      ),
    );
  }
}

