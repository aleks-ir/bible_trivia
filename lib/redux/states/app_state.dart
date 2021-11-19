import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/authentication_status.dart';
import 'package:weekly_bible_trivia/models/validation_status.dart';
import 'package:weekly_bible_trivia/redux/states/app_tab.dart';
import 'package:weekly_bible_trivia/redux/states/home_state.dart';
import 'package:weekly_bible_trivia/redux/states/past_trivia_state.dart';
import 'package:weekly_bible_trivia/redux/states/reader_state.dart';
import 'package:weekly_bible_trivia/redux/states/signin_state.dart';
import 'package:weekly_bible_trivia/redux/states/signup_state.dart';
import 'authentication_state.dart';
import 'local_storage_state.dart';


@immutable
class AppState {
  final AppTab activeTab;
  final HomeState homeState;
  final ReaderState readerState;
  final PastTriviaState pastTriviaState;
  final AuthenticationState authenticationState;
  final SignInState signInState;
  final SignUpState signUpState;
  final LocalStorageState localStorageState;

  const AppState({
    required this.activeTab,
    required this.homeState,
    required this.readerState,
    required this.pastTriviaState,
    required this.authenticationState,
    required this.signInState,
    required this.signUpState,
    required this.localStorageState,
  });

  factory AppState.initial(){
    return AppState(
        activeTab : AppTab.home,
        homeState: HomeState(title: 'Home screen'),
        readerState : ReaderState(title: 'Reader screen'),
        pastTriviaState : PastTriviaState(title: 'Past Trivia screen'),
        authenticationState : AuthenticationState.initial(),
        signInState: SignInState.initial(),
        signUpState: SignUpState.initial(),
        localStorageState: LocalStorageState.initial(),
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
    LocalStorageState? localStorageState,
  }) {
    return AppState(
      homeState: homeState ?? this.homeState,
      activeTab: activeTab ?? this.activeTab,
      signUpState: signUpState ?? this.signUpState,
      authenticationState: authorizationState ?? this.authenticationState,
      pastTriviaState: pastTriviaState ?? this.pastTriviaState,
      signInState: signInState ?? this.signInState,
      readerState: readerState ?? this.readerState,
      localStorageState: localStorageState ?? this.localStorageState,
    );
  }
}
