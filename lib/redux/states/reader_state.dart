import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/verse.dart';

@immutable
class ReaderState {
  final List<Verse> textReader;

  const ReaderState({
    required this.textReader,
  });

  ReaderState copyWith({
    List<Verse>? textReader,
    String? bookName,
    String? chapter,
    bool? loadingData,
  }) {
    return ReaderState(
      textReader: textReader ?? this.textReader,
    );
  }

  factory ReaderState.initial() {
    return const ReaderState(textReader: []);
  }
}
