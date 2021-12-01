import 'package:flutter/cupertino.dart';
import 'package:weekly_bible_trivia/global/enums.dart';

@immutable
class LocalStorageState {
  final Language language;
  final ThemeType theme;
  final double fontSize;

  const LocalStorageState({
    required this.language,
    required this.theme,
    required this.fontSize,
  });

  LocalStorageState copyWith({
    Language? language,
    ThemeType? theme,
    double? fontSize,
  }) {
    return LocalStorageState(
      language: language ?? this.language,
      theme: theme ?? this.theme,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  factory LocalStorageState.initial() {
    return LocalStorageState(
      language: Language.english,
      theme: ThemeType.light,
      fontSize: 20,
    );
  }
}
