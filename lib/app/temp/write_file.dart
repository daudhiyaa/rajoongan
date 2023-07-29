import 'dart:io';

import "package:flutter/material.dart";

class WriteFilePage extends StatefulWidget {
  const WriteFilePage({super.key});

  @override
  State<WriteFilePage> createState() => _WriteFilePageState();
}

class _WriteFilePageState extends State<WriteFilePage> {
  int _counter = 0;
  List<int> listCounter = [];

  void _incrementCounter() {
    setState(() {
      listCounter.add(_counter);
      _counter++;
    });
  }

  void writeListToFile() {
    final file = File('/storage/emulated/0/Download/counter1.txt');
    final sink = file.openWrite();

    for (final item in listCounter) {
      sink.writeln(item);
    }

    sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Text('$_counter'),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: const Text('Increment counter'),
          ),
          ElevatedButton(
            onPressed: writeListToFile,
            child: const Text('Write Data'),
          ),
        ],
      )),
    );
  }
}
