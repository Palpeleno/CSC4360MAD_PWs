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

  //function to add a new note to the database
  Future<void> addNewPage(PageModel page) async {
    final db = await database;
    await db?.insert(
      "pages",
      page.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //function to fetch all pages from the database
  Future<List<PageModel>> getPages() async {
    final db = await database;
    var res = await db!.query("pages");
    if (res.isEmpty) {
      return [];
    } else {
      // Map the result to PageModel using fromMap
      return res.map((page) => PageModel.fromMap(page)).toList();
    }
  }
}
