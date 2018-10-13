import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:orangechat/model/todo.dart';

class DBHelper {
    static final DBHelper _dbhelper = DBHelper._internal();
    static Database _db;

    String tbTodo = "todo";
    String colId = "id";
    String colTitle = "title";
    String colDescription = "description";
    String colPriority = "priority";
    String colDate = "date";

    DBHelper._internal();

    factory DBHelper() {
        return _dbhelper;
    }

    Future<Database> initializeDb() async {
        Directory dir = await getApplicationDocumentsDirectory();
        String path = dir.path + "todos.db";
        var dbTodo = await openDatabase(path, version: 1, onCreate: _createDB);
        return dbTodo;
    }     

    void _createDB(Database db,int newVersion) async{
        await db.execute("CREATE TABLE $tbTodo($colId INTEGER PRIMARY KEY, $colTitle TEXT, "
            + "$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)");
    }

    Future<Database> get database async {
        if (_db == null) _db = await initializeDb();
        return _db;
    }

    Future<int> insertTodo(Todo todo) async {
        Database db = await this.database;
        return await db.insert(this.tbTodo, todo.toMap());
    }

    Future<List> getTodos() async {
        Database db = await this.database;
        return await db.rawQuery("SELECT * FROM $tbTodo order by $colPriority ASC");
    }

    Future<int> getCount() async {
        Database db = await this.database;
        var result = Sqflite.firstIntValue(await db.rawQuery("select count (*) from $tbTodo"));
        return result;
    }

    Future<int> update(Todo todo) async {
        Database db = await this.database;
        var result = await db.update(this.tbTodo, todo.toMap(), where: "$colId = ?", whereArgs: [todo.id]);
        return result;
    }

    Future<int> deleteTodo(Todo todo) async{
        Database db = await this.database;
        // var result = db.delete(this.tbTodo, where: "$colId = ?", whereArgs: [todo.id]);
        return await db.rawDelete("DELETE FROM $tbTodo WHERE $colId = ${todo.id}");
    }

    Future<int> delete(int id) async{
        Database db = await this.database;
        // var result = db.delete(this.tbTodo, where: "$colId = ?", whereArgs: [todo.id]);
        var result = db.rawDelete("DELETE FROM $tbTodo WHERE $colId = $id");
        return result;
    }
}