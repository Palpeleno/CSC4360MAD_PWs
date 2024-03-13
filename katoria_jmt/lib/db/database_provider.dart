import 'dart:async';

import 'package:katoria_jmt/view/model/page_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;
  static final _pagesStreamController = StreamController<List<PageModel>>.broadcast();

  // creating a getter for the the database
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    return openDatabase(join(await getDatabasesPath(), "jornalpage_app.db"),
        onCreate: (db, version) async {
      // create journal table
        await db.execute('''
          CREATE TABLE page(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            title TEXT,
            body TEXT,
            mood TEXT,
            creation_date TEXT
          )
        ''');
      }, version: 2);
  }

  // function to add a new page to the database
  void addNewPage(PageModel page) async {
    final db = await database;
    await db?.insert(
      "page",
      page.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _pagesStreamController.add(await getPages());
  }

  Future<List<PageModel>> getInitialPages() async{
    final db = await database;
    final res = await db!.query("page");

    if(res.isEmpty){
      return [];
    }
    else{
      return res.map((page) => PageModel.fromMap(page)).toList();
    }
  }

  Future<List<PageModel>> getPages() async {
    final db = await database;
    var res = await db!.query("page"); 

    if (res.isEmpty) {
      return [];
    } else {
      return res.map((page) => PageModel.fromMap(page)).toList();
    }
  }
  Stream<List<PageModel>>watchPages()=> _pagesStreamController.stream;
}
