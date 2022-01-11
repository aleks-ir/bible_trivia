import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weekly_bible_trivia/dao/book_dao.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Database? _databaseInstance;

  DatabaseHelper._internal();

  Future<Database> _init() async {

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<Database> get _database async {

    _databaseInstance ??= await _init();

    return _databaseInstance!;
  }

  void _onCreate(Database db, int newVersion) {
    BookDao.createTable(db);
  }

  void close() async {

    Database instance = await _database;
    instance.close();
  }

  Future<BookDao> get bookDao async => BookDao(await _database);
}
