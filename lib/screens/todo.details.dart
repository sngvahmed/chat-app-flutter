import 'package:flutter/material.dart';
import 'package:orangechat/model/todo.dart';
import 'package:orangechat/util/dbhelper.dart';
import 'package:intl/intl.dart';

class TodoDetails extends StatefulWidget {
    final Todo todo;
    TodoDetails(this.todo);

    @override
    State<StatefulWidget> createState() => TodoDetailsState(this.todo);
}

class TodoDetailsState extends State {
    Todo todo;

    TodoDetailsState(this.todo);

    final _priorities = ["High", "Medium", "Low"];
    final _priority = "Low";

    TextEditingController descriptionCtrl = TextEditingController();
    TextEditingController titleCtrl = TextEditingController();

    @override
    Widget build(BuildContext context) {
        titleCtrl.text = todo.title;
        descriptionCtrl.text = todo.description;
        TextStyle textStyle = Theme.of(context).textTheme.title;
        return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(todo.title),
            ),
            body: Padding(
                padding: EdgeInsets.only(top:35.0, left: 10.0, right: 10.0),
                child : ListView(children: <Widget>[ Column(
                    children: <Widget>[
                        TextField(
                            controller: titleCtrl,
                            style: textStyle,
                            decoration: InputDecoration(
                                labelStyle: textStyle,
                                labelText: "Title",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: TextField(
                            controller: descriptionCtrl,
                            style: textStyle,
                            decoration: InputDecoration(
                                labelStyle: textStyle,
                                labelText: "Description",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                        )),
                        ListTile( title: DropdownButton<String>(
                            items: _priorities.map((String priority) {
                                return DropdownMenuItem<String>(
                                    value: priority,
                                    child: Text(priority),
                                );
                            }).toList(),
                            style: textStyle,
                            value: "Low",
                            onChanged: null,
                        ))
                    ],
                )])
            ),
        );
    }
}
