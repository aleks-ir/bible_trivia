import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/database/verse.dart';

@immutable
class SearchState {
  final List<Verse> searchResult;
  final String keyword;
  final int verse;

  const SearchState({
    required this.searchResult,
    required this.keyword,
    required this.verse,
  });

  SearchState copyWith({
    List<Verse>? searchResult,
    String? keyword,
    int? verse,
  }) {
    return SearchState(
        searchResult: searchResult ?? this.searchResult,
        keyword: keyword ?? this.keyword,
        verse: verse ?? this.verse);
  }

  factory SearchState.initial() {
    return const SearchState(
        searchResult: [], keyword: '', verse: 0);
  }
}
