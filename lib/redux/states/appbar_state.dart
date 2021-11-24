import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/constants/enums/menu_bars.dart';
import 'package:weekly_bible_trivia/constants/strings.dart';

@immutable
class AppBarState {
  final MenuBar menuBar;
  final bool isShowMenuBar;

  const AppBarState(
      {required this.menuBar,
        required this.isShowMenuBar,});

  AppBarState copyWith({MenuBar? menuBar, bool? isShowMenuBar,}) {
    return AppBarState(
      menuBar: menuBar ?? this.menuBar,
      isShowMenuBar: isShowMenuBar ?? this.isShowMenuBar,
    );
  }

  factory AppBarState.initial() {
    return AppBarState(
        menuBar: MenuBar.home,
        isShowMenuBar: false,);
  }
}
