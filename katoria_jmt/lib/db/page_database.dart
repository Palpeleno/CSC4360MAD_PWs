import 'package:katoria_jmt/view/model/page.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
          imgRep TEXT,
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
  static Future<List<MyPage>> getPages() async {
    final db = await _database();

    // fetch all items from database
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    //convert the List<Map<string>, syncamc > in to a list of our table
    return List.generate(maps.length, (i) {
      return MyPage(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String,
        description: maps[i]['description'] as String,
        mood: maps[i]['mood'] as String,
        image: maps[i]['imgRep'] as String,
        createdAt: DateTime.parse(maps[i]['createdAt']),
      );
    });
  }

  //update functions for page
  static update({required MyPage page}) async {
    final db = await _database();

    await db.update(
      _tableName,
      page.toMap(),
      where: 'id = ?',
      whereArgs: [page.id],
    );
  }

// delete function
  static delete({required MyPage page}) async {
    final db = await _database();

    await db.delete(_tableName, where: 'id = ?', whereArgs: [page.id]);
  }
}
