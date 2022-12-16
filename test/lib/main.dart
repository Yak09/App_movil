// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:test/screen/Homepage.dart';
import 'package:test/screen/Pokedex.dart';
import 'package:test/screen/Profilepage.dart';
import 'package:test/screen/Ranking.dart';
import 'package:test/screen/Loginpage.dart';

import 'package:flutter_treeview/flutter_treeview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Paralela pokeApi'),
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
  int currentIndex = 0;
  bool _auth = false;
  final screens = [Profilepage(), Ranking(), Pokedex(), LoginScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
        //IndexedStack permite que no se destruyan las otras pantallas cuando se visita otra
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Feed',
            backgroundColor: Color.fromARGB(255, 243, 33, 33),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
            backgroundColor: Color.fromARGB(255, 33, 243, 79),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login_sharp),
            label: 'Login',
            backgroundColor: Color.fromARGB(255, 205, 243, 33),
          ),
        ],
      ),
    );
  }
}
