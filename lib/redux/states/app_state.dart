import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/redux/states/app_tab.dart';
import 'package:weekly_bible_trivia/redux/states/home_state.dart';
import 'package:weekly_bible_trivia/redux/states/past_trivia_state.dart';
import 'package:weekly_bible_trivia/redux/states/reader_state.dart';
import 'package:weekly_bible_trivia/redux/states/signin_state.dart';
import 'package:weekly_bible_trivia/redux/states/signup_state.dart';
import 'authentication_state.dart';


@immutable
class AppState {
  final AppTab activeTab;
  final HomeState homeState;
  final ReaderState readerState;
  final PastTriviaState pastTriviaState;
  final AuthenticationState authorizationState;
  final SignInState signInState;
  final SignUpState signUpState;

  const AppState({
    required this.activeTab,
    required this.homeState,
    required this.readerState,
    required this.pastTriviaState,
    required this.authorizationState,
    required this.signInState,
    required this.signUpState,
  });

  factory AppState.initial(){
    return AppState(
        activeTab : AppTab.home,
        homeState: HomeState(title: 'Home screen'),
        readerState : ReaderState(title: 'Reader screen'),
        pastTriviaState : PastTriviaState(title: 'Past Trivia screen'),
        authorizationState : AuthenticationState(isAuthorized: false),
        signInState: SignInState.initial(),
        signUpState: SignUpState.initial()
    );
  }
  
  AppState copyWith({
    AppTab? activeTab,
    HomeState? homeState,
    ReaderState? readerState,
    PastTriviaState? pastTriviaState,
    AuthenticationState? authorizationState,
    SignInState? signInState,
    SignUpState? signUpState,
  }) {
    return AppState(
      homeState: homeState ?? this.homeState,
      activeTab: activeTab ?? this.activeTab,
      signUpState: signUpState ?? this.signUpState,
      authorizationState: authorizationState ?? this.authorizationState,
      pastTriviaState: pastTriviaState ?? this.pastTriviaState,
      signInState: signInState ?? this.signInState,
      readerState: readerState ?? this.readerState,
    );
  }
}
