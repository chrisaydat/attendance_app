// ignore_for_file: prefer_const_declarations

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "attendance.db";
  static final _databaseVersion = 1;

  static final table = 'attendance';

  static final columnId = '_id';
  static final columnClassName = 'class_name';
  static final columnStudentName = 'student_name';
  static final columnDateTime = 'date_time';
  static final columnIsPresent = 'is_present';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnClassName TEXT NOT NULL,
            $columnStudentName TEXT NOT NULL,
            $columnDateTime TEXT NOT NULL,
            $columnIsPresent INTEGER NOT NULL
          )
          ''');
  }

  // Helper methods

  // Insert a record into the database
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // Get all attendance records
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }
}
