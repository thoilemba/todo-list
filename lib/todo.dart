import 'package:flutter/material.dart';

class Task {
  Task(this.title, this.completed);

  String title;
  bool completed;

  // converting Task object into a Map<String, dynamic>.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'completed': completed,
    };
  }

  // named constructor used for creating Task object from Map<String, dynamic>
  Task.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        completed = map['completed'];
}

// TaskItem class contains the checkbox, title and delete button
class TaskItem extends StatelessWidget {
  const TaskItem(
      {super.key,
      required this.task,
      required this.completeTask,
      required this.deleteTask});

  final Task task;
  final void Function(Task todo) completeTask;
  final void Function(Task todo) deleteTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5),
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 209, 228, 255),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  value: task.completed,
                  onChanged: (value) {
                    completeTask(task);
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(
                              task.title,
                              // textAlign: TextAlign.center,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  completeTask(task);
                                  Navigator.pop(context);
                                },
                                child: task.completed
                                    ? const Text(
                                        "Mark as incomplete",
                                        style: TextStyle(color: Colors.black54),
                                      )
                                    : const Text(
                                        "Mark as complete",
                                        style: TextStyle(color: Colors.green),
                                      ),
                              ),
                              TextButton(
                                onPressed: () {
                                  deleteTask(task);
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        decoration: task.completed ? TextDecoration.lineThrough : null,
                        decorationThickness: 2,
                        decorationColor: Colors.black54,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete Task"),
                          content:
                              const Text("Do you want to delete this task?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // delete the item
                                deleteTask(task);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(color: Colors.red),
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
