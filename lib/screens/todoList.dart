// // import 'dart:async';
// //
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:todo_app/model/todo.dart';
// // import 'package:todo_app/util/dbhelper.dart';
// // import 'package:todo_app/screens/tododetail.dart';
// //
// // class TodoList extends StatefulWidget {
// //   const TodoList({super.key});
// //
// //   @override
// //   State<StatefulWidget> createState() => TodoListState();
// // }
// //
// // class TodoListState extends State {
// //   DbHelper helper = DbHelper();
// //
// //   List<Todo>? todos;
// //   int count = 0;
// //   @override
// //   Widget build(BuildContext context) {
// //     //Let's say for the first time, the todos is null, this should handle it or a try and catch I guess
// //     if (todos == null) {
// //       todos = [
// //         Todo(title: '', date: '', priority: 1, description: ''),
// //         Todo(title: '', date: '', priority: 2, description: ''),
// //         Todo(title: '', date: '', priority: 3, description: ''),
// //         Todo(title: '', date: '', priority: 4, description: ''),
// //       ];
// //       helper.getCount();
// //       //getData();
// //     }
// //     return Scaffold(
// //       body: todoLists() ,//todoListItems(),
// //       floatingActionButton: FloatingActionButton(
// //           onPressed: () {
// //             debugPrint(todoLists() as String?);
// //            // navigateToDetail(Todo(title: '', date: '', priority: 1, description: ''));
// //           },
// //           tooltip: "Add a new Todo",
// //           child: const Icon(Icons.add)),
// //     );
// //   }
// //
// //   FutureBuilder todoLists(){
// //     return FutureBuilder(future: helper.countTodos(),
// //         builder: (context, asyncSnapshot){
// //       dynamic data;
// //       if (!asyncSnapshot.hasData){
// //         return const ScaffoldMessenger(child: Text("Todo List is empty"));
// //       }
// //       if(asyncSnapshot.hasData){
// //          data = asyncSnapshot.data;
// //       }
// //       return Card(
// //         color: Colors.white,
// //         elevation: 2.0,
// //         child: ListView.builder(
// //           itemCount: data,
// //           itemBuilder: (context, index) => ListTile(
// //             leading: CircleAvatar(
// //              // backgroundColor: getColor(todos![position]!.priority),
// //               child: Text("numbers"), //Text(todos![position].priority.toString()),
// //             ),
// //             title: Text(data),
// //             subtitle: Text(''),
// //             onTap: () {
// //              // debugPrint("Tapped on ${todos![position].id}");
// //             //  navigateToDetail(todos![position]!);
// //             },
// //           ),
// //         ),
// //       );
// //         } );
// //   }
// //
// //
// //   ListView todoListItems() {
// //     Future allTodos =  helper.countTodos().then((value) => value);
// //     return ListView.builder(
// //       itemCount: todos!.length,
// //       itemBuilder: (BuildContext context, int position) {
// //         return Card(
// //           color: Colors.white,
// //           elevation: 2.0,
// //           child: ListTile(
// //             leading: CircleAvatar(
// //               backgroundColor: getColor(todos![position]!.priority),
// //               child: Text(todos![position].priority.toString()),
// //             ),
// //             title: Text(todos![position].title),
// //             subtitle: Text(todos![position].date.toString()),
// //             onTap: () {
// //               debugPrint("Tapped on ${todos![position].id}");
// //               navigateToDetail(todos![position]!);
// //             },
// //           ),
// //         );
// //       },
// //     );
// //   }
// //
// //   void getData() {
// //     final dbFuture = helper
// //         .initializeDb(); //dbFuture is a future so, only untill we get it can we do something with it that is why the .then() is called later
// //     dbFuture.then((result) {
// //       final todosFuture = helper
// //           .getTodos(); //retrieves all records from the todos table and its a future hence , we call the .then() method again
// //       todosFuture.then((result) {
// //         List<Todo>?
// //             todoList; //a temporary list of all records from the database
// //         count = result.length;
// //         for (int i = 0; i < count; i++) {
// //           todoList!.add(Todo.fromObject(result[i]));
// //           debugPrint(todoList[i].title); //this is to test if it's working
// //         }
// //         setState(() {
// //           todos = todoList;
// //           count = count;
// //         });
// //         debugPrint("items$count"); //this is also to test
// //       });
// //     });
// //   }
// //
// //   Color getColor(int priority) {
// //     Color color;
// //     switch (priority) {
// //       case 1:
// //         color = Colors.red;
// //         break;
// //       case 2:
// //         color = Colors.orange;
// //         break;
// //       case 3:
// //         color = Colors.green;
// //         break;
// //       default:
// //         color = Colors.green;
// //     }
// //     return color;
// //   }
// //
// //   void navigateToDetail(Todo todo) async {
// //     bool result = await Navigator.push(
// //         context, MaterialPageRoute(builder: (context) => TodoDetail(todo)));
// //     if(result == true){
// //       getData();
// //     }
// //   }
// // }








// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:todo_app/util/dbhelper.dart';
//
// import '../model/todo.dart';
//
// class TodoScreen extends StatefulWidget {
//   const TodoScreen({super.key});
//
//   @override
//   State<TodoScreen> createState() => _TodoScreenState();
// }
//
// class _TodoScreenState extends State<TodoScreen> {
//   final DatabaseHelper _databaseHelper = DatabaseHelper();
//   List<Todo> _todos = [];
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   int _priority = 1;
//   int? selectedValue;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _retrieveTodos();
//   }
//
//   Future<void> _retrieveTodos() async {
//     List<Todo> todos = await _databaseHelper.getTodos();
//     setState(() {
//       _todos = todos;
//     });
//   }
//
//   Future<void> _addTodo() async {
//     if (_titleController.text.isNotEmpty &&
//         _descriptionController.text.isNotEmpty) {
//       Todo newTodo = Todo(
//         title: _titleController.text,
//         description: _descriptionController.text,
//         priority: _priority,
//       );
//       await _databaseHelper.insertTodo(newTodo);
//       _titleController.clear();
//       _descriptionController.clear();
//       _priority = 1;
//       _retrieveTodos();
//     }
//     selectedValue = null;
//   }
//
//   Future<void> _deleteTodoById(int id) async {
//     await _databaseHelper.deleteTodoById(id);
//     _retrieveTodos();
//   }
//
//   Color _getPriorityColor(int priority) {
//     switch (priority) {
//       case 1:
//         return Colors.red;
//       case 2:
//         return Colors.yellow;
//       case 3:
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Todo List'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Title',
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _descriptionController,
//               decoration: const InputDecoration(
//                 labelText: 'Description',
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: DropdownButton<int>(
//               hint: const Text('Select Priority'),
//               value: selectedValue,
//               items: const [
//                 DropdownMenuItem(
//                    value: 1,
//                     child: Text(
//                       'High priority',
//                      // style: TextStyle(color: Colors.red),
//                     )),
//                 DropdownMenuItem(
//                     value: 2,
//                     child: Text(
//                       'Average priority',
//                      // style: TextStyle(color: Colors.yellow),
//                     )),
//                 DropdownMenuItem(
//                     value: 3,
//                     child: Text(
//                       'Low priority',
//                      // style: TextStyle(color: Colors.green),
//                     )),
//               ],
//               onChanged: (value) {
//                 setState(() {
//                   selectedValue = value!;
//                 });
//               },
//             ),
//           ),
//           ElevatedButton(
//             onPressed:_addTodo,
//             child: const Text('Add Todo'),
//           ),
//           Expanded(
//             child: ListView.builder(
//                 itemCount: _todos.length,
//                 itemBuilder: (context, index) {
//                   final todo = _todos[index];
//                   return Card(
//                     child: ListTile(
//                       title: Text(todo.title),
//                       subtitle: Text(todo.description),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: () => _deleteTodoById(todo.id!),
//                       ),
//                       tileColor: _getPriorityColor(todo.priority),
//                     ),
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }
