import 'package:flutter/material.dart';
import 'package:orangechat/util/dbhelper.dart';
import 'package:orangechat/model/todo.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State {
  DBHelper dbHelper = DBHelper();
  List<Todo> todoList;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<Todo>();
      getData();
    }

    return Scaffold(
      body: todlistItem(),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'A',
        child: new Icon(Icons.add),
      ),
    );
  }

  ListView todlistItem() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext bContext, int postition) {
        return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(this.todoList[postition].id.toString()),
              ),
              title: Text(this.todoList[postition].title),
              subtitle: Text(this.todoList[postition].date),
              onTap: () {
                debugPrint(
                    "Tapped on " + this.todoList[postition].id.toString());
              },
            ));
      },
    );
  }

  void getData() {
    final dbFuture = dbHelper.initializeDb();
    dbFuture.then((result) {
      dbHelper.getTodos().then((todos) {
        for (int i = 0; i < todos.length; i++) {
          todoList.add(Todo.fromObject(todos[i]));
          debugPrint(todoList[i].title);
          setState(() {
            todos = todoList;
            count = todoList.length;
          });
        }
      });
    });
  }
}
