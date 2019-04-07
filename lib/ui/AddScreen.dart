import 'package:flutter/material.dart';
import '../model/Todo.dart';

class Addform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddformState();
  }
}

class AddformState extends State<Addform> {
  TextEditingController item = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  TodoProvider todo = TodoProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Subject"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child: TextFormField(
                controller: item,
                decoration: InputDecoration(
                  labelText: "Subject",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill subject";
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child: RaisedButton(
                child: Text("Save"),
                onPressed: () async {
                  _formkey.currentState.validate();
                  if(item.text.length > 0){
                    await todo.open();
                    Todo data = Todo(title: item.text);
                    todo.insert(data).then((d){
                      Navigator.pushNamed(context, "/");
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}