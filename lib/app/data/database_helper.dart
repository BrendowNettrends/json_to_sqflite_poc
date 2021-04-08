import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static Database _database;


  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if(_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if(_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "database.db";

    var itemsDatabase = await openDatabase(path, version: 1, onCreate: _createDatabase);


    return itemsDatabase;
  }

  void _createDatabase(Database db, int newVersion) async {

    await db.execute('CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT, username TEXT, email TEXT, phone TEXT, website TEXT)');
  }



}