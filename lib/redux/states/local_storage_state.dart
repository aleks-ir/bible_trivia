import 'package:flutter/cupertino.dart';
import 'package:weekly_bible_trivia/constants/enums/languages.dart';
import 'package:weekly_bible_trivia/constants/enums/themes.dart';

@immutable
class LocalStorageState {
  final Languages language;
  final Themes theme;
  final double fontSize;

  const LocalStorageState({
    required this.language,
    required this.theme,
    required this.fontSize,
  });

  LocalStorageState copyWith({
    Languages? language,
    Themes? theme,
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
      language: Languages.english,
      theme: Themes.light,
      fontSize: 20,
    );
  }
}
