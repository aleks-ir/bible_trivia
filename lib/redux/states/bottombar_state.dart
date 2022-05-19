import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/enums.dart';

@immutable
class BottomBarState {
  final NavigationTab activeTab;
  final bool isActiveAnimation;

  const BottomBarState(
      {required this.activeTab,
      required this.isActiveAnimation});

  BottomBarState copyWith({NavigationTab? activeTab, bool? isActiveAnimation}) {
    return BottomBarState(
      activeTab: activeTab ?? this.activeTab,
      isActiveAnimation: isActiveAnimation ?? this.isActiveAnimation,
    );
  }

  factory BottomBarState.initial() {
    return const BottomBarState(
      activeTab: NavigationTab.home,
      isActiveAnimation: false);
  }
}
