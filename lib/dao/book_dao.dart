import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:weekly_bible_trivia/models/database/verse.dart';

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

    List<Verse> listVerses =
        res.isNotEmpty ? res.map((c) => Verse.fromJson(c)).toList() : [];

    return listVerses;
  }

  @override
  Future<List<Verse>> getByKeyword(String keyword) async {
    final res = await _database.rawQuery(
        "SELECT * FROM $TABLE_NAME WHERE $TEXT LIKE '%$keyword%'");

    // final res = await compute(getRes,
    //     "SELECT * FROM $TABLE_NAME WHERE $TEXT LIKE '%$keyword%'");
    List<Verse> listSearchItem =
    res.isNotEmpty ? res.map((c) => Verse.fromJson(c)).toList() : [];

    return listSearchItem;
  }

  // Future<List<Map<String, Object?>>> getRes(String sql) async{
  //   return await _database.rawQuery(sql);
  // }
  
  @override
  Future runInsertVerses(List<Verse> verses) async {
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
  Future<int> deleteAllVerses() async {
    return await _database.rawDelete('DELETE FROM $TABLE_NAME');
  }

  @override
  Future<int?> count() async {
    return Sqflite.firstIntValue(await _database.rawQuery('SELECT COUNT(*) FROM $TABLE_NAME'));
  }
}
