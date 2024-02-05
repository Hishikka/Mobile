import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic entries = ['0'];
  double result = 0;

  void _addElement(elem) {
    setState(() {
      if (entries.length == 1 && entries.last == '0' && elem != '.') {
        entries.first = elem;
      }
      else if (['+', '-', '*', '/'].contains(elem)) {
        entries.add(elem);
        entries.add('');
      }
      else if (['+', '-', '*', '/'].contains(entries.last)) {
        entries.add('');
        entries.last += elem;
      }
      else {
        entries.last += elem;
      }
    });
  }

  void _clearLastElement() {
    setState(() {
      if (entries.length == 1 && entries.first.length == 1) {
        entries.first = '0';
      }
      else if (entries[entries.length - 1].length > 1) {
        var ls = entries[entries.length - 1].split('');
        ls.removeLast();
        entries[entries.length - 1] = ls.join('');
      }
      else {
        entries.removeLast();
      }
    });
  }

  void _calculate() {
    setState(() {
      var nums = [];
      var ops = [];

      print(entries);
      for (int i = 0; i < entries.length; i++) {
        if (i % 2 == 0) {
          nums.add(double.parse(entries[i].trim()));
        }
        else {
          ops.add(entries[i].trim());
        }
      }

      if (entries.length % 2 != 1) {
        ops.removeLast();
      }

      if (ops.any((elem) => ['*', '/'].contains(elem))) {
        for (int i = 0; i < ops.length; i++) {
          if (ops[i] == '*') {
            nums[i] *= nums[i + 1];}
          else if (ops[i] == '/') {
            nums[i] /= nums[i + 1];}
          nums.removeAt(i + 1);
          ops.removeAt(i);
          i--;
        }
      }

      result = nums.first;
      for (int i = 0; i < ops.length; i++) {
        if (ops[i] == '+') {
          result += nums[i + 1];
        }
        else if (ops[i] == '-') {
          result -= nums[i + 1];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Center(child: Text(widget.title)),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${entries.join(' ')}', style: const TextStyle(fontSize: 20)),
                        Container(alignment: Alignment.center,
                            width: 128, height: 40, margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                            child:
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(onPressed: () {_clearLastElement();},
                                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.redAccent)),
                                      child: const Text("<C", style: TextStyle(color: Colors.white, fontSize: 20))),
                                  ElevatedButton(onPressed: () {_calculate();},
                                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)),
                                      child: const Text("=", style: TextStyle(color: Colors.white, fontSize: 28))),])),
                        Text('${result - result.truncate() == 0 ? result.truncate() : result.toStringAsFixed(4)}', style: const TextStyle(fontSize: 20)),
                      ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: () {_addElement('1');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Text("1", style: TextStyle(color: Colors.white, fontSize: 24))),
                        ElevatedButton(onPressed: () {_addElement('2');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Text("2", style: TextStyle(color: Colors.white, fontSize: 24))),
                        ElevatedButton(onPressed: () {_addElement('3');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Text("3", style: TextStyle(color: Colors.white, fontSize: 24))),
                        ElevatedButton(onPressed: () {_addElement('+');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Icon(Icons.add)),
                      ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: () {_addElement('4');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Text("4", style: TextStyle(color: Colors.white, fontSize: 24))),
                        ElevatedButton(onPressed: () {_addElement('5');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Text("5", style: TextStyle(color: Colors.white, fontSize: 24))),
                        ElevatedButton(onPressed: () {_addElement('6');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Text("6", style: TextStyle(color: Colors.white, fontSize: 24))),
                        ElevatedButton(onPressed: () {_addElement('-');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Icon(Icons.remove)),
                      ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: () {_addElement('7');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Text("7", style: TextStyle(color: Colors.white, fontSize: 24))),
                        ElevatedButton(onPressed: () {_addElement('8');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Text("8", style: TextStyle(color: Colors.white, fontSize: 24))),
                        ElevatedButton(onPressed: () {_addElement('9');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Text("9", style: TextStyle(color: Colors.white, fontSize: 24))),
                        ElevatedButton(onPressed: () {_addElement('*');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Text("*", style: TextStyle(color: Colors.white, fontSize: 24))),
                      ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: () {setState(() {entries = ['0']; result = 0;});},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.redAccent)),
                            child: const Text("CA", style: TextStyle(color: Colors.white, fontSize: 24))),
                        ElevatedButton(onPressed: () {_addElement('0');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Text("0", style: TextStyle(color: Colors.white, fontSize: 24))),
                        ElevatedButton(onPressed: () {_addElement('.');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Text(".", style: TextStyle(color: Colors.white, fontSize: 24))),
                        ElevatedButton(onPressed: () {_addElement('/');},
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                            child: const Text("/", style: TextStyle(color: Colors.white, fontSize: 24)))
                      ]),
                ])
        )
    );
  }
}