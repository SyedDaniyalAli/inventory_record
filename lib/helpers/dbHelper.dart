import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class DBHelper {

  static const DB_NAME='InventoryRecord.db';
  static const TABLE_NAME='records';

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    //Create the database if not created and open if already created
    return sql.openDatabase(path.join(dbPath, DB_NAME),
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE records (id INTEGER PRIMARY KEY, clientName TEXT, purchaseDate TEXT, purchasePrice TEXT, retailPrice TEXT)");
        },
        //It is all up to you
        version: 1);
  }

  static Future<void> insert({
    @required String clientName,
    @required DateTime purchaseDate,
    @required double purchasePrice,
    @required double retailPrice,
  }) async {
    final db = await DBHelper.database();
    db.insert(
      TABLE_NAME,
      <String, Object>{'clientName': clientName,'purchaseDate': purchaseDate,'purchasePrice': purchasePrice,'retailPrice': retailPrice },
      conflictAlgorithm: ConflictAlgorithm.replace, // It will override the data if already exist
    );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DBHelper.database();
    return db.query(TABLE_NAME); // It will return the list of Maps
  }

}
