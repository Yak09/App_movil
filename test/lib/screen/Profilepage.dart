import 'package:flutter/material.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _Profilepage();
}

class _Profilepage extends State<Profilepage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 114, 54, 54),
        title: Text("Profile"),
      ),
      body: Center(
        child: Text("Center of Profile"),
      ),
    );
  }
}
