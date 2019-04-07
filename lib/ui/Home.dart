import 'package:flutter/material.dart';
import './CompletedScreen.dart';
import './Task.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _selectedPage = 0;
  final _pageOptions = [Task(), Completed()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted), title: Text("Task")),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all), title: Text("Completed"))
        ],
      ),
    );
  }
}