import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/constants/strings.dart';
import 'package:weekly_bible_trivia/redux/states/appbar_state.dart';
import 'package:weekly_bible_trivia/redux/states/home_state.dart';
import 'package:weekly_bible_trivia/redux/states/past_trivia_state.dart';
import 'package:weekly_bible_trivia/redux/states/reader_state.dart';
import 'package:weekly_bible_trivia/redux/states/signin_state.dart';
import 'package:weekly_bible_trivia/redux/states/signup_state.dart';

import 'authentication_state.dart';
import 'bottombar_state.dart';
import 'info_trivia_state.dart';
import 'local_storage_state.dart';

@immutable
class AppState {
  final BottomBarState bottomBarState;
  final HomeState homeState;
  final ReaderState readerState;
  final PastTriviaState pastTriviaState;
  final AuthenticationState authenticationState;
  final SignInState signInState;
  final SignUpState signUpState;
  final LocalStorageState localStorageState;
  final AppBarState appBarState;
  final InfoTriviaState infoTriviaState;

  const AppState({
    required this.bottomBarState,
    required this.homeState,
    required this.readerState,
    required this.pastTriviaState,
    required this.authenticationState,
    required this.signInState,
    required this.signUpState,
    required this.localStorageState,
    required this.appBarState,
    required this.infoTriviaState,
  });

  factory AppState.initial() {
    return AppState(
      bottomBarState: BottomBarState.initial(),
      homeState: HomeState.initial(),
      readerState: ReaderState(title: TEST_TEXT),
      pastTriviaState: PastTriviaState.initial(),
      authenticationState: AuthenticationState.initial(),
      signInState: SignInState.initial(),
      signUpState: SignUpState.initial(),
      localStorageState: LocalStorageState.initial(),
      appBarState: AppBarState.initial(),
      infoTriviaState: InfoTriviaState.initial(),
    );
  }

  AppState copyWith(
      {BottomBarState? bottomBarState,
      HomeState? homeState,
      ReaderState? readerState,
      PastTriviaState? pastTriviaState,
      AuthenticationState? authorizationState,
      SignInState? signInState,
      SignUpState? signUpState,
      LocalStorageState? localStorageState,
      AppBarState? homeAppBarState,
      InfoTriviaState? infoTriviaState}) {
    return AppState(
      homeState: homeState ?? this.homeState,
      bottomBarState: bottomBarState ?? this.bottomBarState,
      signUpState: signUpState ?? this.signUpState,
      authenticationState: authorizationState ?? this.authenticationState,
      pastTriviaState: pastTriviaState ?? this.pastTriviaState,
      signInState: signInState ?? this.signInState,
      readerState: readerState ?? this.readerState,
      localStorageState: localStorageState ?? this.localStorageState,
      appBarState: homeAppBarState ?? this.appBarState,
      infoTriviaState: infoTriviaState ?? this.infoTriviaState,
    );
  }
}
