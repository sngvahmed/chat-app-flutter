import 'package:flutter/material.dart';
import 'package:orangechat/util/dbhelper.dart';
import 'package:orangechat/model/todo.dart';
import 'package:orangechat/screens/todo.details.dart';

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
                onPressed: (){
                	this.navigateToTodo(Todo(DateTime.now().toString(), 1, "", ""));
                },
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
                            backgroundColor: getColorPriority(this.todoList[postition].priority),
                            child: Text(this.todoList[postition].priority.toString()),
                        ),
                        title: Text(this.todoList[postition].title),
                        subtitle: Text(this.todoList[postition].date),
                        onTap: () {
                            navigateToTodo(this.todoList[postition]);
                        },
                ));
            },
        );
    }

    void navigateToTodo(Todo todo) async {
        var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => TodoDetails(todo)));
        getData();
    }

    Color getColorPriority(int priority) {
        switch (priority) {
            case 1:
                return Colors.red;
            case 2:
                return Colors.orange;
            default:
                return Colors.green;
        }
    }

    void getData() {
	    todoList = [];
        final dbFuture = dbHelper.initializeDb();
        dbFuture.then((result) {
            dbHelper.getTodos().then((todos) {
                for (int i = 0; i < todos.length; i++) {
                    todoList.add(Todo.fromObject(todos[i]));
                }
                setState(() {
	                todos = todoList;
	                count = todoList.length;
                });
            });
        });
    }
}
