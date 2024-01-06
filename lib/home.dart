import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mytodo/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late SharedPreferences prefs;

  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTodoItems();
  }

  // task name, will be taken from the text field
  String title = '';

  // Load the list of tasks and assigned to the tasks
  Future<void> _loadTodoItems() async {
    prefs = await SharedPreferences.getInstance();
    final List<String>? savedTasks = prefs.getStringList('tasks');
    if (savedTasks != null) {
      setState(() {
        // creating the task objects using fromMap() from the json by converting into Map
        tasks = savedTasks.map((task) {
          Map<String, dynamic> taskMap = json.decode(task);
          return Task.fromMap(taskMap);
        }).toList();
      });
    }
  }

  // Saving the list of tasks by converting the task object into Map using toMap() and then to json
  void _saveTaskItems() {
    final List<String> encodedTasks = tasks.map((task) => json.encode(task.toMap())).toList();
    prefs.setStringList('tasks', encodedTasks);
  }

  void addTaskItem(String title, bool completed){
    setState(() {
      tasks.add(Task(title, false));
      _saveTaskItems();
    });
  }

  void _completeTask(Task task) {
    setState(() {
      task.completed = !task.completed;
      _saveTaskItems();
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      tasks.removeWhere((element) => element.title == task.title);
      _saveTaskItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Todo List',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 4, bottom: 74),
        children: tasks.map((Task todo) {
          return TaskItem(
            task: todo,
            completeTask: _completeTask,
            deleteTask: _deleteTask,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Theme.of(context).colorScheme.inversePrimary,
        tooltip: 'Add task',
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:  [
                        const Text(
                          'Add Task',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 158, 202, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextField(
                          autofocus: true,
                          cursorColor: Colors.grey,
                          minLines: 1,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 202, 255),
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(12.0),),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 202, 255),
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(12.0),),
                            ),
                            hintText: "Enter task",
                            hintStyle: TextStyle(
                              color: Colors.grey
                            ),
                          ),
                          onChanged: (newTitle){
                            title = newTitle;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                Color.fromARGB(255, 158, 202, 255),
                              ),
                            ),
                            onPressed: (){
                              if(title.isNotEmpty){
                                addTaskItem(title, false);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          );
        },
        child: const Icon(
          Icons.add,
          // size: 28,
        ),
      ),
    );
  }
}
