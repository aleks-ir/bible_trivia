import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/redux/states/appbar_state.dart';
import 'package:weekly_bible_trivia/redux/states/edit_profile_state.dart';
import 'package:weekly_bible_trivia/redux/states/home_state.dart';
import 'package:weekly_bible_trivia/redux/states/loading_state.dart';
import 'package:weekly_bible_trivia/redux/states/past_trivia_state.dart';
import 'package:weekly_bible_trivia/redux/states/reader_state.dart';
import 'package:weekly_bible_trivia/redux/states/signin_state.dart';
import 'package:weekly_bible_trivia/redux/states/signup_state.dart';
import 'package:weekly_bible_trivia/redux/states/theme_settings.dart';

import 'authentication_state.dart';
import 'bottombar_state.dart';
import 'info_trivia_state.dart';
import 'local_storage_state.dart';

@immutable
class AppState {
  final LoadingState loading;
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
  final ThemeSettingsState themeSettingsState;
  final EditProfileState editProfileState;


  const AppState({
    required this.loading,
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
    required this.themeSettingsState,
    required this.editProfileState,
  });



  factory AppState.initial() {
    return AppState(
      loading: LoadingState.initial(),
      bottomBarState: BottomBarState.initial(),
      homeState: HomeState.initial(),
      readerState: ReaderState.initial(),
      pastTriviaState: PastTriviaState.initial(),
      authenticationState: AuthenticationState.initial(),
      signInState: SignInState.initial(),
      signUpState: SignUpState.initial(),
      localStorageState: LocalStorageState.initial(),
      appBarState: AppBarState.initial(),
      infoTriviaState: InfoTriviaState.initial(),
      themeSettingsState: ThemeSettingsState.initial(),
      editProfileState: EditProfileState.initial(),

    );
  }

  AppState copyWith(
      {LoadingState? loading,
        BottomBarState? bottomBarState,
      HomeState? homeState,
      ReaderState? readerState,
      PastTriviaState? pastTriviaState,
      AuthenticationState? authorizationState,
      SignInState? signInState,
      SignUpState? signUpState,
      LocalStorageState? localStorageState,
      AppBarState? homeAppBarState,
      InfoTriviaState? infoTriviaState,
      ThemeSettingsState? themeSettingsState,
      EditProfileState? editProfileState}) {
    return AppState(
      loading: loading ?? this.loading,
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
      themeSettingsState: themeSettingsState ?? this.themeSettingsState,
      editProfileState: editProfileState ?? this.editProfileState,
    );
  }
}
