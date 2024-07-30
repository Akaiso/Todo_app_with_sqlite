// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:todo_app/model/todo.dart';
// import 'package:intl/intl.dart';
// import 'package:todo_app/util/dbhelper.dart';
//
//
// DbHelper helper = DbHelper();
// final List<String> choices = const <String>[
//   'Save Todo & back',
//   'Delete Todo',
//   'Back to List'
// ];
//
// const mnuSave = 'Save Todo & back';
// const mnuDelete = 'Delete Todo';
// const mnuBack = 'Back to List';
//
//
// class TodoDetail extends StatefulWidget {
//   final Todo todo;
//   TodoDetail(this.todo);
//
//   @override
//   State<StatefulWidget> createState() => TodoDetailState();
// }
//
// class TodoDetailState extends State {
//   Todo? todo;
//   final _priorities = ["High", "Medium", "Low"];
//   String _Priority = "Low";
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     titleController.text = todo!.title;
//     descriptionController.text = todo!.description!;
//     TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(todo!.title!),
//         actions: <Widget>[
//           PopupMenuButton<String>(onSelected: select,
//               itemBuilder: (BuildContext context){
//             return choices.map((String choice) {return PopupMenuItem<String>(
//                 value: choice,
//                 child: Text(choice),);},).toList();
//               }
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 35, left: 10, right: 10.0),
//         //wrapping the column in a listview will prevent the yellow and black lines from showing when the phone is rotated to landscape view
//         child: ListView(
//           children: [
//             Column(
//               children: [
//                 TextField(onChanged: (value){
//                   this.updateTitle();
//     },
//                   controller: titleController,
//                   style: textStyle,
//                   decoration: InputDecoration(
//                       labelText: "Title",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5.0))),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     top: 15.0,
//                     bottom: 15.0,
//                   ),
//                   child: TextField(
//     onChanged: (value){updateDescription();},
//                     controller: descriptionController,
//                     style: textStyle,
//                     decoration: InputDecoration(
//                         labelText: "Description",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0))),
//                   ),
//                 ),
//                 ListTile(
//                   title: DropdownButton<String>(
//                       items: _priorities.map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       value: retrievePriority(todo!.priority),
//                       onChanged: (value) {
//                         updatePriority(value!);
//     }),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void select(String value) async{
//     int? result;
//     switch(value){
//       case mnuSave: save();
//       break;
//       case mnuDelete:
//         Navigator.pop(context, true);
//         if(todo!.id == null){
//           return;
//         }
//         result = await helper.deleteTodo(todo!.id!);
//         if(result != 0){
//           AlertDialog alertDialog = AlertDialog(
//             title: Text('Delete Todo'),
//              content: Text('The Todo had been deleted')
//           );
//           showDialog(context: context, builder: (_)=> alertDialog);
//
//         }
//
//       break;
//       case mnuBack: Navigator.pop(context, true);
//       break;
//       default:
//     }
//   }
//
//   void save(){
//     todo!.date = new DateFormat.yMd().format(DateTime.now());
//     if(todo!.id != null){
//       helper.updateTodo(todo!);
//     }else{
//       helper.insertTodo(todo!);
//     }
//     Navigator.pop(context, true);
//   }
//
//   void updatePriority(String value){
//     switch(value){
//       case "High":
//         todo!.priority = 1;
//         break;
//       case "Medium":
//         todo!.priority = 2;
//         break;
//       case "low":
//         todo!.priority = 3;
//         break;
//     }
//     setState(() {
//       _Priority = value;
//     });
//   }
//
//   String retrievePriority(int value){
//     return _priorities[value - 1]; //-1 is because the array index begins at zero and our first priority is 1
//   }
//   //method to update the title of our todo
// void updateTitle(){
//     todo!.title = titleController.text;
// }
//
// void updateDescription(){
//     todo!.description = descriptionController.text;
// }
// }
