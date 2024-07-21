import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/model/todo.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal(); //Number 1
  //create constants that will help in our query of the database. we can use RAW SQl like db.rawQuery("SELECT * From yourTable"),
  // db.rawInsert('INSERT INTO yourTable(name, num) VALUES("some name", 1234)');
  // db.rawUpdate('UPDATE yourTable SET name = ?, WHERE name = ?', ["new name","old name"]);
  // db.rawDelete('DELETE FROM yourTable WHERE id = 1');
  // ...or
  //Using the SQFlite helpers as thus:
  // db.update(
  //     'yourTable',
  // yourObject.toMap(),
  // where: "colId = ?",
  // whereArgs = [yourObject.id]
  //     );

  //name of the table will be todo

  String tblTodo = "todo";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colPriority = "priority";
  String colDate = "date";

  DbHelper._internal(); //Number 2 ; the named constructor

  //Since we need to call this class once in our app, we need a singleton. The class doesn't have to be instantiated more than once
//This class contains methods to retrieve data from the database; may read or write.
//the factory constructor helps to return only one (the same) instance of a class
//the following steps are required (Numbers 1,2 and 3);
//Create a private instance of a class: static final DbHelper _dbhelper = new DbHelper._internal();
//Create an empty private named constructor :  DbHelper._internal();
//Use the factory to always return the same instance:  factory DbHelper(){return _dbhelper;}

//Number 3
  factory DbHelper() {
    return _dbHelper;
  }

  //create variable that will contain the database through out the class
  static Database? _db;

  //Also create a getter
  Future<Database?> get db async {
    _db ??=
        await initializeDb(); // old format if (_db == null) {_db = await initializeDb();}
    return _db;
  }

//The method that will actually open or initialize the database
  Future<Database> initializeDb() async {
    Directory dir =
        await getApplicationCacheDirectory(); //Directory is from the .io package and the getApp...() is from the path_provider package
    //it will return the directory for the documents of our application.
    String path =
        dir.path + "todos.db"; //let's call the name of our database todos.db
    var dbTodos = await openDatabase(path,
        version: 1,
        onCreate:
            _createDb); //It takes in the path, version and what to do if the database does not exist
    return dbTodos;
  }

  //This will create the database we use above should there be no database
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblTodo($colId INTEGER PRIMARY KEY, $colTitle TEXT, " +
            "$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)");
  }

  //Query methods
  Future<int> insertTodo(Todo todo) async {
    Database? db = await this.db;
    var result = await db!.insert(tblTodo,
        todo.toMap()); //The insert helper method requires the name of the table and a map of the record we want to insert
    return result;
  } //if id is 0, then something went wrong

//method that will return all the todos
  Future<List> getTodos() async {
    Database? db = await this.db;
    var result = await db!.rawQuery(
        "SELECT * FROM $tblTodo order by $colPriority ASC"); //The ASC means in ascending order
    return result;
  }

//To get the number of records in our table
  Future<int?> getCount() async {
    Database? db = await this.db;
    var result = Sqflite.firstIntValue(
        await db!.rawQuery("select count (*) from $tblTodo"));
    return result;
  }

//The update method
  Future<int?> updateTodo(Todo todo) async {
    var db = await this.db;
    var result = await db?.update(
        tblTodo, todo.toMap(), where: "$colId =?", whereArgs: [
      todo.id
    ]); // takes the name of the table, a map of the object we want to update and since it's an update, we include which record we want to update the [todo.id] is an array as it may contain multiple arguments
    return result;
  }

//The delete
  Future<int?> deleteTodo(int id) async {
    int result;
    var db =
        await this.db; //after getting our database, we call the delete method
    result = await db!.rawDelete('DELTE FROM $tblTodo WHERE $colId = $id');
    return result;
    //the db helper is now ready . Try it out
  }
}
