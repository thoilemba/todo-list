import 'package:flutter/material.dart';
import 'package:mytodo/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // TODO: Use this if we want to used the Task class and TaskItem class
  // List<Task> tasks = [];
  // void _loadAllTasks() async {
  //   final data = await DatabaseHelper.getItems();
  //   setState(() {
  //     tasks = data.map((e){
  //       return Task.fromMap(e);
  //     }).toList();
  //   });
  // }

  List<Map<String, dynamic>> _todoList = [];
  String title = '';
  // bool _isLoading = true;

  void _loadAllTasks() async {
    final data = await DatabaseHelper.getItems();
    setState(() {
      _todoList = data;
      // _isLoading = false;
    });
  }

  Future<void> _addTask(String title, int completed) async {
    await DatabaseHelper.createItem(title, completed);
    _loadAllTasks();
  }

  Future<void> _deleteTask(int id) async {
    await DatabaseHelper.deleteItem(id);
    _loadAllTasks();
  }

  Future<void> _updateTask(int id, String title, int completed, String createdAt) async {
    if(completed == 1){
      completed = 0;
    }else{
      completed = 1;
    }
    await DatabaseHelper.updateItem(id, title, completed, createdAt);
    _loadAllTasks();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadAllTasks();
  }

  String myLocalDateTime = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    // log('_journals length: ${_todoList.length}');
    // log('myLocalDateTime: $myLocalDateTime');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Todo List',
        ),
      ),
      // TODO: Use this body if we want to used the Task class and TaskItem class
      // body: ListView(
      //   padding: const EdgeInsets.symmetric(vertical: 8.0),
      //   children: tasks.map((Task task) {
      //     return TaskItem(
      //       task: task,
      //       deleteTask: (int id) => _deleteTask(task.id),
      //       updateTask: (int id, String title, int completed) => _updateTask(task.id, task.title, task.completed, task.createdAt),
      //     );
      //   }).toList(),
      // ),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          final task = _todoList[index];
          return Card(
            // elevation: 3,
            color: const Color.fromARGB(255, 209, 228, 255),
            child: ListTile(
              leading: SizedBox(
                width: 10,
                child: Checkbox(
                  value: task['completed'] == 1 ? true : false,
                  onChanged: (value){
                    // completeTask(task);
                    _updateTask(task["id"], task['title'], task['completed'], task['createdAt']);
                  },
                ),
              ),
              title: Text(
                task['title'],
                style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                  decoration: task['completed'] == 1 ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text('Created at: ${task['createdAt']}'),
              trailing: SizedBox(
                width: 20,
                child: IconButton(
                  onPressed: () {
                    _deleteTask(task['id']);
                  },
                  icon: const Icon(Icons.delete),

                ),
              ),
              // onTap: () {
              //   // Handle the tap on the list item
              //   print('Tapped on ${task['title']}');
              // },
            ),
          );
        },
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
                              // addTaskItem(title, false);
                              _addTask(title, 0);
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
