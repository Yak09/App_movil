import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  final String title;
  const Homepage({super.key, required this.title});

  @override
  State<Homepage> createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("Autorizado"),
      ),
    );
  }
}
