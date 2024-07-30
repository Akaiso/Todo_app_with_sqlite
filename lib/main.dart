import 'package:flutter/material.dart';
import 'package:todo_app/screens/taskList.dart';
import 'package:todo_app/screens/todoList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //this part of the code was just used to test the app before building the UI
    //instantiate the dbhelper
    //List<Tod*> todos = List<Tod*>();
    // DbHelper helper = DbHelper(); //first, we need to read if there are todos in the database. first, it's gonna be empty till we input tod*
    // List<Tod*>? todos;
    // helper.initializeDb().then(
    //     (result) => helper.getTodos().then(<Tod*>(result) => todos = result));
    // DateTime today = DateTime.now();
    // Tod* tod* = Tod*("Buy Apples",  today.toString(),1, "And make sure they are good");
    // helper.insertTodo(tod*);

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),useMaterial3: false
      ),
      debugShowCheckedModeBanner: false,
      title: 'Todos',
      home: const TaskList(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: const TodoList(),
//     );
//   }
// }
