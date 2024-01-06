import 'package:flutter/material.dart';
import 'package:mytodo/home.dart';

void main() {
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
