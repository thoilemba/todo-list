import 'package:flutter/material.dart';
import 'package:mytodo/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<Todo> todos = [
    Todo('1. Buy bread and milk.\n2. Buy juice.\n'
        '3. Do something great to have a good memory when remembered.', false),
    Todo('title', false)
  ];

  String title = '';

  void addTodoItem(String title, bool completed){
    setState(() {
      todos.add(Todo(title, false));
    });
  }

  void _completeTodo(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      todos.removeWhere((element) => element.title == todo.title);
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
        children: todos.map((Todo todo) {
          return TodoItem(
            todo: todo,
            completeTodo: _completeTodo,
            deleteTodo: _deleteTodo,
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
                                addTodoItem(title, false);
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
