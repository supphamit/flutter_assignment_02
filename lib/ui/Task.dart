import 'package:flutter/material.dart';
import '../model/todo.dart';

class Task extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskState();
  }
}

class TaskState extends State<Task> {
  TodoProvider todo = TodoProvider();

  List<Todo> _notToDones = List();
  @override
  void initState() {
    super.initState();
    todo.open().then((x) {
      task();
    });
  }

  void task() {
    todo.getNotDones().then((x) {
      setState(() {
        _notToDones = x;
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
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, "/new");
            },
          )
        ],
      ),
      body: _notToDones.length == 0
          ? Center(child: Text('No data found...'))
          : ListView(
              children: _notToDones.map((todoItem) {
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