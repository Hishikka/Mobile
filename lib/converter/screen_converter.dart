import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double celsius = 0, fahrenheit = 0;

  void _convertTemperature(){
    setState(() {
      fahrenheit = (celsius * 9/5) + 32;
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
                    onChanged: (value) => celsius = double.parse(value),
                  )),
              Text('$fahrenheit', style: const TextStyle(fontSize: 30)),
              FloatingActionButton.extended(
                  onPressed: _convertTemperature,
                  label: const Text('Convert', style: TextStyle(fontSize: 36))
              ),
            ]),
      ),
    );
  }

}
