import 'package:weekly_bible_trivia/models/database/verse.dart';

class UpdateSearchResultAction {
  final List<Verse> searchResult;
  UpdateSearchResultAction(this.searchResult);
}

class UpdateKeywordAction {
  final String keyword;
  UpdateKeywordAction(this.keyword);
}

class UpdateSearchVerseAction {
  final int verse;
  UpdateSearchVerseAction(this.verse);
}

class ClearSearchAction{}