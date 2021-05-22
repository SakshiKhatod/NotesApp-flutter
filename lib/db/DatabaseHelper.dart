import 'package:new_app/model/Note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = "notes.db";
  final tableName = "notes";

  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    print("Init DB");
    print("Inside path");
    String path = await getDatabasesPath();
    print(path);
    var dbPath = join(path, 'notes.db');
    // ignore: argument_type_not_assignable
    Database dbConnection =
        await openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      print("executing create query from onCreate callback");
      print("Path");
      print(path);
      print(dbPath);
      await db.execute(''' CREATE TABLE notes (
               id INTEGER PRIMARY KEY AUTOINCREMENT,
               title TEXT,
             body TEXT,
            creationDate DATE)
            ''');
    });
    print(dbConnection);
    return dbConnection;
  }

  addNewNote(NoteModel note) async {
    print("In add note");

    final db = await database;
    print("Insert started...");
    db.insert("notes", note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("End of note");
  }

  Future<dynamic> getNotes() async {
    print("In get notes");
    final db = await database;

    var res = await db.query("notes");
    print("Res value");
    print(res);
    print("Res value length");
    print(res.length);
    print("Res value list");
    print(res.toList());
    if (res.length == 0) {
      return Null;
    } else {
      var resultMap = res.toList();
      print("Resultmap value");
      print(resultMap);
      return resultMap.isNotEmpty ? resultMap : Null;
    }
  }

  Future<int> deleteNote(int id) async {
    print("In delete note");
    final db = await database;
    int count = await db.rawDelete("DELETE FROM notes WHERE id=?", [id]);
    print("Count");
    print(count);
    return count;
  }
}
