import 'dart:async';

import 'package:json_to_sqflite_poc/app/data/database_helper.dart';
import 'package:json_to_sqflite_poc/app/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class Repository {

  DatabaseHelper _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseHelper();
  }

  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await _databaseConnection.initializeDatabase();
    return _database;
  }

  Future<void> insertUser(UserModel user) async {
    var connection = await database;

    return await connection.insert('User', user.toJson());
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    var connection = await database;
    return await connection.query('User');
  }

}