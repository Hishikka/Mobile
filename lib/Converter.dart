import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Temperature Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double Celsius = 0, Fahrenheit = 0;

  void _buttonConvert(){
    setState(() {
      Fahrenheit = (Celsius * 9/5) + 32;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Temperature converter", style: TextStyle(
                  fontSize: 30)),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                hintText: 'Enter temperature in Celsius',
                ),
                onChanged: (value) => Celsius = double.parse(value),
              )),
              Text('$Fahrenheit', style: const TextStyle(fontSize: 30)),
              FloatingActionButton.extended(
                onPressed: _buttonConvert,
                label: const Text('Convert', style: TextStyle(fontSize: 36))
              ),
            ]),
        ),
      );
  }




}
