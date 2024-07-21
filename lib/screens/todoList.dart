import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/util/dbhelper.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State {
  DbHelper helper = DbHelper();
  List<Todo>? todos ;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    //Let's say for the first time, the todos is null, this should handle it or a try and catch I guess
    if (todos == null) {
      todos =
      [
        Todo("unamed 1", helper.colDate, 1),
        Todo("unamed 7", helper.colDate, 2),
        Todo("unamed 1", helper.colDate, 3),
        Todo("unamed 2", helper.colDate, 4),
        Todo("unamed 2", helper.colDate, 4)
      ];
      getData();
    }
    return Scaffold(
      body: todoListItems(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: "Add a new Todo",
          child: const Icon(Icons.add)),
    );
  }

  ListView todoListItems() {
    return ListView.builder(
      itemCount: todos!.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor(todos![position].priority),
              child: Text(todos![position].priority.toString()),
            ),
            title: Text(todos![position].title!),
            subtitle: Text(todos![position].date.toString()),
            onTap: () {
              debugPrint("Tapped on " + todos![position].id.toString());
            },
          ),
        );
      },
    );
  }

  void getData() {
    final dbFuture = helper
        .initializeDb(); //dbFuture is a future so, only untill we get it can we do something with it that is why the .then() is called later
    dbFuture.then((result) {
      final todosFuture = helper
          .getTodos(); //retrieves all records from the todos table and its a future hence , we call the .then() method again
      todosFuture.then((result) {
        List<Todo>?
            todoList; //a temporary list of all records from the database
        count = result.length;
        for (int i = 0; i < count; i++) {
          todoList!.add(Todo.fromObject(result[i]));
          debugPrint(todoList[i].title); //this is to test if it's working
        }
        setState(() {
          todos = todoList;
          count = count;
        });
        debugPrint("items" + count.toString()); //this is also to test
      });
    });
  }

   Color getColor(int priority){
    Color color;
    switch(priority){
      case 1: color = Colors.red;
      break;
      case 2: color = Colors.orange;
      break;
      case 3: color = Colors.green;
      break;
      default: color = Colors.green;
    }
    return color;
  }
}
