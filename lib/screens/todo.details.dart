import 'package:flutter/material.dart';
import 'package:orangechat/model/todo.dart';
import 'package:orangechat/util/dbhelper.dart';
import 'package:intl/intl.dart';

DBHelper dbHelper = DBHelper();
final List<String> menuChoices = const <String> [
    'Save Todo & Back', 'Delete Todo', 'Back to List'
];

const menuSave = 'Save Todo & Back';
const menuDelete = 'Delete Todo';
const menuBack = 'Back to List';

class TodoDetails extends StatefulWidget {
    final Todo todo;
    TodoDetails(this.todo);

    @override
    State<StatefulWidget> createState() => TodoDetailsState(this.todo);
}

class TodoDetailsState extends State {
    Todo todo;
    final _priorities = ["High", "Medium", "Low"];
    var _priority = "Low";

    TodoDetailsState(this.todo);

    TextEditingController descriptionCtrl = TextEditingController();
    TextEditingController titleCtrl = TextEditingController();

    TextField buildTextField(String title, TextStyle textStyle, TextEditingController ctrl, changeTextField) {
      return TextField(
        controller: ctrl,
        style: textStyle,
        onChanged: changeTextField,
        decoration: InputDecoration(
            labelStyle: textStyle,
            labelText: title,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0))),
      );
    }

    DropdownButton buildDropdownButton(TextStyle textStyle) {
        return DropdownButton<String>(
          items: _priorities.map((String priority) {
            return DropdownMenuItem<String>(
              value: priority,
              child: Text(priority),
            );
          }).toList(),
          style: textStyle,
          value: retreivePriorty(todo.priority),
          onChanged: (val) => updatePrioirty(val),
        );
    }

    List<Widget> buildActionMenu() {
        return <Widget>[PopupMenuButton<String>(
            onSelected: selectMenu,
            itemBuilder: (BuildContext bcontxt){
                return menuChoices.map((String choice) {
                    return PopupMenuItem<String>(
                        child: Text(choice),
                        value: choice,
                    );
                }).toList();
            },
        )];
    }

    void selectMenu(String value) async {
        int result;
        switch(value){
            case menuSave:
                result = await saveMenuAction();
                Navigator.pop(context, true);
                break;
            case menuBack:
	            Navigator.pop(context, true);
                break;
            case menuDelete:
	            Navigator.pop(context, true);
                if (todo.id == null) return;
                result = await this.deleteActionMenu();
                break;
        }
    }

     deleteActionMenu() async {
	    int result = await dbHelper.deleteTodo(todo);
	    if (result != 0) {
		    showDialog(context: context, builder: (_) => AlertDialog(
			    title: Text("Delete Todo"),
			    content: Text("todo has been deleted"),
		    ));
	    }
	    return await result;
    }

    saveMenuAction() async {
        todo.date = DateFormat.yMd().format(DateTime.now());
        if (todo.id != null) { dbHelper.update(todo); return 1; }
        return await dbHelper.insertTodo(todo);
    }

    void updatePrioirty(String value) {
        switch(value) {
            case "High":
                todo.priority = 1;
                break;
            case "Medium":
                todo.priority = 2;
                break;
            default:
                todo.priority = 3;
                break;
        }
        setState(() {
            this._priority = value;
        });
    }

    String retreivePriorty(int val) => this._priorities[val - 1];

    void updateTitle(String text) { todo.title = text; }

    void updateDescritpion(String text) { todo.description = text; }

    @override
    Widget build(BuildContext context) {
        titleCtrl.text = todo.title;
        descriptionCtrl.text = todo.description;
        TextStyle textStyle = Theme.of(context).textTheme.title;
        return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(todo.title),
                actions: buildActionMenu(),
            ),
            body: Padding(
                padding: EdgeInsets.only(top:35.0, left: 10.0, right: 10.0),
                child : ListView(children: <Widget>[ Column(
                    children: <Widget>[
                        buildTextField("Title", textStyle, titleCtrl, this.updateTitle),
                        Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: buildTextField("Description", textStyle, descriptionCtrl, this.updateDescritpion)
                        ),
                        ListTile( title: buildDropdownButton(textStyle))
                    ],
                )])
            ),
        );
    }
}
