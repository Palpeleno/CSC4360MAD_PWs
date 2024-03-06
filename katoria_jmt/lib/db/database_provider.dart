// import 'package:flutter/material.dart';
import 'package:katoria_jmt/view/model/page_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

// creating a getter for database
  Future<Database?> get database async {
    // checks if existing db exist
    // ignore: unnecessary_null_comparison
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), "jornalpage_app.db"),
        onCreate: (db, version) async {
      //create jounral table
      await db.execute('''

        CREATE TABLE notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          title TEXT,
          body TEXT,
          mood TEXT,
          imgRep TEXT,
          creation_date DATE
        )
        ''');
    }, version: 1);
  }

  // FUNCTIONS  tha will add new note to our variable
  addNewNote(PageModel page) async {
    final db = await database;
    db?.insert(
      "pages",
      page.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
// fucntion fetch for database to return all elements inside page table
    Future<dynamic> getPage() async {
      final db = await database;
      var res = await db!.query("pages");
      if (res.isEmpty) {
        return Null;
      } else {
        var resultMap = res.toList();
        return resultMap.isNotEmpty ? resultMap : Null;
      }
    }
  }

  getPages() {}
}
