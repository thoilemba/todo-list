import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {

  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      completed INTEGER NOT NULL,
      createdAt TEXT
    )""");
  }

  static Future<Database> db() async {
    return openDatabase(
      'todo_list.db',
      version: 1,
      onCreate: (Database database, int version) async {
        if (kDebugMode) {
          print('Creating a table');
        }
        await createTables(database);
      }
    );
  }


  static Future<int> createItem(String title, int completed) async {
    final db = await DatabaseHelper.db();
    var now = DateTime.now().toString();
    final data = {'title': title, 'completed': completed, 'createdAt': now};
    final id = await db.insert('tasks', data, conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseHelper.db();
    return db.query('tasks', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('tasks', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String title, int completed, String createdAt) async {
    final db = await DatabaseHelper.db();
    final data = {
      'title': title,
      'completed': completed,
      // 'createdAt': createdAt
      'createdAt': DateTime.now().toString() // used to update date of completed
    };

    final result = await db.update('tasks', data, where: "id = ?", whereArgs: [id]);
    log("Called db.update()");
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DatabaseHelper.db();

    try{
      await db.delete("tasks", where: "id = ?", whereArgs: [id]);
    }catch(e){
      debugPrint("Something went wrong when deleting and item: $e");
    }
  }

}
