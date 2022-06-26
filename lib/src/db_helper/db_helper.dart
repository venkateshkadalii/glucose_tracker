import 'package:glucose_tracker/src/models/reading.dart';
import 'package:glucose_tracker/src/models/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _userTableName = "users";
  static const String _readingHistoryTable = "readings";


  static Future<void> initDb() async {
    if(_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}glucose.db';
      _db = await openDatabase(path, version: _version, onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE   $_userTableName("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "first_name TEXT, last_name TEXT, age INTEGER, "
              "gender TEXT, phone TEXT, password TEXT)",
        );
        await db.execute(
          "CREATE TABLE   $_readingHistoryTable("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "type TEXT, value INTEGER, date TEXT, phone TEXT)",
        );
      });
    } catch (error) {
      print(error);
    }
  }

  static Future<int> insertUser(User user) async {
    return await _db?.insert(_userTableName, user.toJson()) ?? -1;
  }

  static Future<int> insertReading(Reading reading) async {
    return await _db?.insert(_readingHistoryTable, reading.toJson()) ?? -1;
  }

  static Future<User?> validateUser({required String phone, required String password}) async {
    await _db?.query(_userTableName, where: 'phone=? and password=?', whereArgs: [phone, password]);
    var res = await _db?.rawQuery(
        "SELECT * FROM $_userTableName WHERE phone = '$phone' and password = '$password'");
    if(res != null && res.length > 0) {
      return User.fromJson(res.first);
    }
    return null;
  }

  static Future<List<Map<String, dynamic>>?> getReadingHistory(String phone) async {
    return await _db?.query(_readingHistoryTable, where: 'phone=?', whereArgs: [phone]);
  }
}