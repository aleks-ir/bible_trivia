import 'dart:async';

import 'package:weekly_bible_trivia/models/verse.dart';


abstract class Dao<T> {


  Future<int> createVerse(Verse verse);
  Future runInsertVerses(List<Verse> verses);
  Future<List<Verse>> getChapter(String bookName, int chapter);
  void createNewTable();
  Future<int> deleteAllVerses();
  Future<int?> count();
}