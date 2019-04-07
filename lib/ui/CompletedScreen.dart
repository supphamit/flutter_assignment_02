import 'package:flutter/material.dart';
import '../model/todo.dart';

class Completed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CompletedState();
  }
}

class CompletedState extends State<Completed> {
  TodoProvider todo = TodoProvider();

  List<Todo> _doneItems = List();
  @override
  void initState() {
    super.initState();
    todo.open().then((x) {
      task();
    });
  }

  void task() {
    todo.getDones().then((x) {
      setState(() {
        _doneItems = x;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Todo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              todo.delete();
              task();
            },
          )
        ],
      ),
      body: _doneItems.length == 0
          ? Center(child: Text('No data found...'))
          : ListView(
              children: _doneItems.map((todoItem) {
                return CheckboxListTile(
                  title: Text(todoItem.title),
                  value: todoItem.done,
                  onChanged: (bool value) {
                    setState(() {
                      todoItem.done = value;
                      todo.update(todoItem);
                      task();
                    });
                  },
                );
              }).toList(),
            ),
    );
  }
}