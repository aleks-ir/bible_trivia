import 'package:flutter/cupertino.dart';
import 'package:weekly_bible_trivia/global/constants.dart';

@immutable
class LocalStorageState {
  final String bookName;
  final String translationId;
  final int chapter;
  final String language;
  final String theme;
  final double fontSize;

  const LocalStorageState({
    required this.bookName,
    required this.translationId,
    required this.chapter,
    required this.language,
    required this.theme,
    required this.fontSize,
  });

  LocalStorageState copyWith({
    String? bookName,
    String? translationId,
    int? chapter,
    String? language,
    String? theme,
    double? fontSize,
  }) {
    return LocalStorageState(
      bookName: bookName ?? this.bookName,
      translationId: translationId ?? this.translationId,
      chapter: chapter ?? this.chapter,
      language: language ?? this.language,
      theme: theme ?? this.theme,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  factory LocalStorageState.initial() {
    return const LocalStorageState(
      bookName: DEFAULT_BOOK_NAME,
      translationId: DEFAULT_TRARSLATION_ID,
      chapter: 1,
      language: ENGLISH,
      theme: LIGHT,
      fontSize: DEFAULT_FONT_SIZE,
    );
  }
}
