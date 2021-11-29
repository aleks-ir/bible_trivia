import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/enums.dart';

@immutable
class BottomBarState {
  final NavigationTab activeTab;

  const BottomBarState(
      {required this.activeTab,});

  BottomBarState copyWith({NavigationTab? activeTab,}) {
    return BottomBarState(
      activeTab: activeTab ?? this.activeTab,
    );
  }

  factory BottomBarState.initial() {
    return BottomBarState(
      activeTab: NavigationTab.home,);
  }
}
