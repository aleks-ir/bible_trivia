import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:weekly_bible_trivia/models/verse.dart';

import 'dao.dart';

class BookDao extends Dao<Verse> {
  static const String TABLE_NAME = 'Bible';
  static const String CHAPTER = 'chapter';
  static const String VERSE = 'verse';
  static const String TEXT = 'text';
  static const String TRANSLATION_ID = 'translation_id';
  static const String BOOK_ID = 'book_id';
  static const String BOOK_NAME = 'book_name';

  final Database _database;

  BookDao(this._database);

  static void createTable(Database database) async {
    await database.execute('CREATE TABLE $TABLE_NAME('
        '$CHAPTER INTEGER, '
        '$VERSE INTEGER, '
        '$TEXT TEXT, '
        '$TRANSLATION_ID TEXT, '
        '$BOOK_ID TEXT, '
        '$BOOK_NAME TEXT '
        ')');
  }

  @override
  Future<List<Verse>> getChapter(String bookName, int chapter) async {
    final res = await _database.rawQuery(
        "SELECT * FROM $TABLE_NAME WHERE book_name = '$bookName' AND chapter = '$chapter'");

    List<Verse> list =
        res.isNotEmpty ? res.map((c) => Verse.fromJson(c)).toList() : [];

    return list;
  }

  @override
  Future runInsertVerses(List<Verse> verses) async {
    String sql = 'INSERT INTO $TABLE_NAME VALUES';
    return await _database.transaction((txn) async {
        var batch = txn.batch();
        for(Verse v in verses){
          batch.insert(TABLE_NAME, v.toJson());
        }
        await batch.commit();
      });
  }

  @override
  Future<int> createVerse(Verse verse) async {
    return await _database.insert(TABLE_NAME, verse.toJson());
  }

  @override
  void createNewTable() async {
    return await _database.execute('CREATE TABLE $TABLE_NAME('
        '$CHAPTER INTEGER, '
        '$VERSE INTEGER, '
        '$TEXT TEXT, '
        '$TRANSLATION_ID TEXT, '
        '$BOOK_ID TEXT, '
        '$BOOK_NAME TEXT '
        ')');
  }
  
  @override
  Future<int> deleteAllVerses() async {
    return await _database.rawDelete('DELETE FROM $TABLE_NAME');
  }

  @override
  Future<int?> count() async {
    return Sqflite.firstIntValue(await _database.rawQuery('SELECT COUNT(*) FROM $TABLE_NAME'));
  }
}
