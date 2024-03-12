import 'package:katoria_jmt/view/model/page_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

    // creating a getter for the the database
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), "jornalpage_app.db"),
      onCreate: (db, version) async {
        // create journal table
        await db.execute('''
        CREATE TABLE page(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          title TEXT,
          body TEXT,
          mood TEXT,
          creation_date TEXT
          
        ''');
    }, version: 1);
  }

  // function to add a new page to the database
  Future<void> addNewPage(PageModel page) async {
    final db = await database;
    await db?.insert(
      "pages",
      page.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //  function to fetch all pages from the database
  Future<List<PageModel>> getPages() async {
    final db = await database;
    var res = await db!.query("page"); // corrected table name
 
    if (res.isEmpty) {
      return [];
    } else {
      // Map the result to PageModel using fromMap
      return res.map((page) => PageModel.fromMap(page)).toList();
    }
  }
}
