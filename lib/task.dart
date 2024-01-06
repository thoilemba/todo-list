import 'package:flutter/material.dart';

class Task {

  Task(this.title, this.completed);

  String title;
  bool completed;

}

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task, required this.completeTask, required this.deleteTask});

  final Task task;
  final void Function(Task todo) completeTask;
  final void Function(Task todo) deleteTask;

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
                  value: task.completed,
                  onChanged: (value){
                    completeTask(task);
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
                            decoration: task.completed ? TextDecoration.lineThrough : null,
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
                                deleteTask(task);
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
