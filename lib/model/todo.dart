import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String tableTodo = "todo";
final String columnId = "_id";
final String columnTitle = "title";
final String columnDone = "done";

class Todo {
  int id;
  String title;
  bool done = false;

  //Constructor
  Todo({String title}) {
    this.title = title;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    done = map[columnDone] == 1;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnDone: done == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }
}

class TodoProvider {
  Database db;

  Future open() async {
    var dbpath = await getDatabasesPath();
    String path = dbpath + "\todo.db";

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $tableTodo(
        $columnId integer primary key autoincrement,
        $columnTitle Text not null,
        $columnDone integer not null)
      ''');
    });
  }
    Future<List<Todo>> getDones() async {
    var data = await db.query(tableTodo, where: '$columnDone = 1');
    return data.map((d) => Todo.fromMap(d)).toList();
  }
  
  Future<Todo> insert(Todo todo) async {
    await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<List<Todo>> getNotDones() async {
    var data = await db.query(tableTodo, where: '$columnDone = 0');
    print(data);
    return data.map((d) => Todo.fromMap(d)).toList();
  }

  

  Future<void> update(Todo todo) async {
    await db.update(
      tableTodo,
      todo.toMap(),
      where: '$columnId = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> delete() async {
    return await db.delete(tableTodo, where: "$columnDone = 1");
  }

  Future<int> deleteAll() async {
    return await db.delete(tableTodo);
  }

  Future close() async => db.close();
}