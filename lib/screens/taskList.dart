import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/util/dbhelper.dart';
import '../model/task.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Task> taskList = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTaskList();
  }

  Future<void> _getTaskList() async {
    List<Task> tasks = await _databaseHelper.getAllTasks();
    setState(() {
      taskList = tasks;
    });
  }

  Future<void> _putTask() async{
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      Task newtask = Task(
        title: _titleController.text,
        description: _descriptionController.text,
      );
      await _databaseHelper.addTask(newtask);
      _titleController.clear();
      _descriptionController.clear();
       _getTaskList();
      debugPrint(
          'This is newtask :::::::::::::::::::::::::::::>>>>>${newtask.title + newtask.description}');
    }
  }

  Future<void> _deleteTaskById(int id) async {
    await _databaseHelper.deleteTask(id);
    _getTaskList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0),
                  )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0),
                  )),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
              onTap: _putTask,
              child: Container(
                  color: Colors.deepOrange,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Add Task'),
                  ))),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  final atask = taskList[index];
                  return Card(
                    color: Colors.blue,
                    child: ListTile(
                        title: Text(
                      atask.title,
                    )),
                  );
                }),
          )
        ],
      ),
    );
  }
}
