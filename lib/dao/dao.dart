import 'dart:async';

import 'package:weekly_bible_trivia/models/database/verse.dart';

abstract class Dao<T> {
  Future<int> createVerse(Verse verse);

  Future<List<Verse>> getByKeyword(String keyword);

  Future runInsertVerses(List<Verse> verses);

  Future<List<Verse>> getChapter(String bookName, int chapter);

  Future<int> deleteAllVerses();

  Future<int?> count();
}
