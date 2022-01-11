import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/enums.dart';

@immutable
class AppBarState {
  final MenuBar menuBar;
  final bool isShowMenuBar;
  final bool isReaderMod;
  final bool isOldTestament;

  const AppBarState(
      {required this.menuBar,
        required this.isShowMenuBar,
        required this.isReaderMod,
      required this.isOldTestament});

  AppBarState copyWith({MenuBar? menuBar, bool? isShowMenuBar, bool? isReaderMod, bool? isOldTestament}) {
    return AppBarState(
      menuBar: menuBar ?? this.menuBar,
      isShowMenuBar: isShowMenuBar ?? this.isShowMenuBar,
      isReaderMod: isReaderMod ?? this.isReaderMod,
      isOldTestament: isOldTestament ?? this.isOldTestament,
    );
  }

  factory AppBarState.initial() {
    return const AppBarState(
        menuBar: MenuBar.home,
        isReaderMod: false,
        isShowMenuBar: false,
        isOldTestament: true);
  }
}
