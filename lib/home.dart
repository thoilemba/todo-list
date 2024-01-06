import 'package:flutter/material.dart';
import 'package:mytodo/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<Task> tasks = [
    Task('1. Buy bread and milk.', false),
    Task('Buy juice.', false),
    Task('Do something great for the day.', false)
  ];

  String title = '';

  void addTaskItem(String title, bool completed){
    setState(() {
      tasks.add(Task(title, false));
    });
  }

  void _completeTask(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      tasks.removeWhere((element) => element.title == task.title);
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
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: tasks.map((Task todo) {
          return TaskItem(
            task: todo,
            completeTask: _completeTask,
            deleteTask: _deleteTask,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
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
                            color: Colors.lightBlueAccent,
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
                              borderSide: BorderSide(color: Colors.blue, width: 3.0),
                              borderRadius: BorderRadius.all(Radius.circular(12.0),),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue, width: 3.0),
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
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlueAccent),
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
