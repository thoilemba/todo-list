
import 'package:flutter/material.dart';

class Todo {

  Todo(this.title, this.completed);

  String title;
  bool completed;

}

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.todo, required this.completeTodo, required this.deleteTodo});

  final Todo todo;
  final void Function(Todo todo) completeTodo;
  final void Function(Todo todo) deleteTodo;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {


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
                  value: widget.todo.completed,
                  onChanged: (value){
                    widget.completeTodo(widget.todo);
                  },
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.todo.title,
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            decoration: widget.todo.completed ? TextDecoration.lineThrough : null,
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
                                widget.deleteTodo(widget.todo);
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
    // return Card(
    //   elevation: 2,
    //   child: ListTile(
    //     onLongPress: (){
    //       showMenu(
    //         context: context,
    //         position: const RelativeRect.fromLTRB(100, 100, 0, 0),
    //         items: [
    //           const PopupMenuItem(
    //             child: Text('Edit'),
    //           ),
    //           const PopupMenuItem(
    //             child: Text('Delete'),
    //           ),
    //         ],
    //       );
    //     },
    //     leading: Checkbox(
    //       activeColor: Colors.lightBlueAccent,
    //       value: widget.todo.completed,
    //       onChanged: (value){
    //         _handleTodoChange(widget.todo);
    //       },
    //     ),
    //     title: Text(widget.todo.description,
    //       style: const TextStyle(
    //         // color: Colors.green,
    //           fontSize: 16
    //       ),
    //     ),
    //     trailing: PopupMenuButton(
    //       itemBuilder: (context) {
    //         return [
    //           const PopupMenuItem(
    //             value: 'edit',
    //             child: Text('Edit'),
    //           ),
    //           const PopupMenuItem(
    //             value: 'delete',
    //             child: Text('Delete'),
    //           ),
    //         ];
    //       },
    //     ),
    //   ),
    // );
  }
}
