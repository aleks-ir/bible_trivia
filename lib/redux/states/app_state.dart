import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/redux/states/app_tab.dart';
import 'package:weekly_bible_trivia/redux/states/home_state.dart';
import 'package:weekly_bible_trivia/redux/states/past_trivia_state.dart';
import 'package:weekly_bible_trivia/redux/states/reader_state.dart';
import 'authorization_state.dart';


@immutable
class AppState {
  final HomeState homeState;
  final ReaderState readerState;
  final PastTriviaState pastTriviaState;
  final AuthorizationState authorizationState;
  final AppTab activeTab;


  const AppState({
    this.homeState = const HomeState(title: 'Home screen'),
    this.readerState = const ReaderState(title: 'Reader screen'),
    this.pastTriviaState = const PastTriviaState(title: 'Past Trivia screen'),
    this.authorizationState = const AuthorizationState(isAuthorized: false),
    this.activeTab = AppTab.home,

  });

  AppState copyWith({
    required HomeState homeState, required AppTab activeTab,
  }) {
    return AppState(
      homeState: homeState,
      activeTab: activeTab,
    );
  }
}
