import 'package:flutter/material.dart';

/*
  This task.dart file optional.
  If we want to used the todolist items as object,
  Use these two class: Task and TaskItem
 */

// This class represent each single todolist item
class Task {

  Task(this.id, this.title, this.completed, this.createdAt);

  int id;
  String title;
  int completed;
  String createdAt;

  // converting Task object into a Map<String, dynamic>.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'createdAt': createdAt,
    };
  }

  // named constructor used for creating Task object from Map<String, dynamic>
  Task.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        completed = map['completed'],
        createdAt = map['createdAt'];

}

/*
  This class provides each rounded container that contains checkbox, task title and delete icon
  Custom design for the ListTile Widget
 */
class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task, required this.deleteTask, required this.updateTask});

  final Task task;
  final Future<void> Function(int id) deleteTask;
  final Future<void> Function(int id, String title, int completed) updateTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.inversePrimary,
          color: const Color.fromARGB(255, 209, 228, 255),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: task.completed == 1 ? true : false,
                  onChanged: (value){
                    // completeTask(task);
                    updateTask(task.id, task.title, task.completed);
                  },
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            decoration: task.completed == 1 ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                IconButton(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete Task"),
                          content: const Text("Do you want to delete this task?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // delete the item
                                deleteTask(task.id);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                  color: Colors.red
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("No"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
