import 'package:katoria_jmt/view/model/page.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

// our local database
// database manipulation functions
//

class PageRepository {
  static const _dbName = 'journalpage_app.db';
  static const _tableName = 'pages';

  static Future<Database> _database() async {
    final database = openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      // create journal table
      return db.execute('''
        CREATE TABLE $_tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          title TEXT,
          description TEXT,
          mood TEXT,
          createdAt TEXT
        )
      ''');
    }, version: 1);

    return database;
  }

  // function to add a new page to the database
  static insert({required MyPage page}) async {
    final db = await _database();
    await db.insert(
      _tableName,
      page.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // function to fetch all pages from the database
  // static Future<List<MyPage>> getPages() async {
  //   final db = await _database();
  //   var res = await db.query(_tableName);

  //   if (res.isEmpty) {
  //     return [];
  //   } else {
  //     // Map the result to MyPage using fromMap
  //     return res.map((page) => MyPage.fromMap(page)).toList();
  //   }
  // }
}
