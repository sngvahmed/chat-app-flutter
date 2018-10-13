import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orangechat/model/todo.dart';
import 'package:orangechat/util/dbhelper.dart';

class TodoDetailService {
	final BuildContext context;
	Todo todo;
	final DBHelper dbHelper;

	TodoDetailService(this.context, this.todo, this.dbHelper);

	static const menuSave = 'Save Todo & Back';
	static const menuDelete = 'Delete Todo';
	static const menuBack = 'Back to List';

	void selectMenu(String value) async {
		switch(value){
			case menuSave:
				await saveMenuAction();
				Navigator.pop(context, true);
				break;
			case menuBack:
				Navigator.pop(context, true);
				break;
			case menuDelete:
				Navigator.pop(context, true);
				if (todo.id == null) return;
				await this.deleteActionMenu();
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

}