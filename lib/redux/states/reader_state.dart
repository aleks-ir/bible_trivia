import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/verse.dart';

@immutable
class ReaderState {
  final List<Verse> textReader;
  final String bookName;
  final String chapter;
  final bool loadingData;

  const ReaderState({
    required this.textReader,
    required this.bookName,
    required this.chapter,
    required this.loadingData,
  });

  ReaderState copyWith({
    List<Verse>? textReader,
    String? bookName,
    String? chapter,
    bool? loadingData,
  }) {
    return ReaderState(
      textReader: textReader ?? this.textReader,
      bookName: bookName ?? this.bookName,
      chapter: chapter ?? this.chapter,
      loadingData: loadingData ?? this.loadingData
    );
  }

  factory ReaderState.initial() {
    return const ReaderState(textReader: [], bookName: "Genesis", chapter: "1", loadingData: false);
  }
}
