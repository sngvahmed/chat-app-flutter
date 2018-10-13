import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orangechat/screens/todo/todo.list.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: "Todos",
            theme: ThemeData(primarySwatch: Colors.deepOrange),
            home: TodoHomePage(title: "Todo",),
        );
    }
}

class TodoHomePage extends StatefulWidget {
    TodoHomePage({Key key, this.title}) : super(key: key);
    final String title;

    @override
    State<StatefulWidget> createState() => TodoHomePageState();
}

class TodoHomePageState extends State<TodoHomePage> {
    
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar( title: Text("Todo"),),
          body: TodoList(),
      );
  }

}