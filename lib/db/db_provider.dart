import 'dart:io';
import 'package:flutter_sample01/db/model/message.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  final TABLE_NAME_USER = "User";
  final TABLE_NAME_MSSEAGE = "Message";

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory document = await getApplicationDocumentsDirectory();
    String path = p.join(document.path, "jadejunDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
      onCreate: (Database db, int version) async{
      await db.execute("CREATE TABLE $TABLE_NAME_MSSEAGE ("
            "idx INTEGER PRIMARY KEY AUTOINCREMENT,"
            "user_name TEXT,"
            "msg TEXT"
            ")"
        );
      }
    );
  }

  insertMessage(Message message) async {
    final db = await database;
    var res = await db.insert(TABLE_NAME_MSSEAGE, message.toJson());
    return res;
  }

  getMessage() async {
    final db = await database;
    var res = await db.query(TABLE_NAME_MSSEAGE);
    List<Message> list = res.isNotEmpty ? res.map((f) => Message.fromJson(f)).toList() : [];
    return list;
  }
}
