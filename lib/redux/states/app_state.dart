import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/redux/states/appbar_state.dart';
import 'package:weekly_bible_trivia/redux/states/edit_profile_state.dart';
import 'package:weekly_bible_trivia/redux/states/loading_state.dart';
import 'package:weekly_bible_trivia/redux/states/past_trivia_state.dart';
import 'package:weekly_bible_trivia/redux/states/reader_state.dart';
import 'package:weekly_bible_trivia/redux/states/search_state.dart';
import 'package:weekly_bible_trivia/redux/states/signin_state.dart';
import 'package:weekly_bible_trivia/redux/states/signup_state.dart';
import 'package:weekly_bible_trivia/redux/states/table_result_state.dart';
import 'package:weekly_bible_trivia/redux/states/theme_settings.dart';
import 'package:weekly_bible_trivia/redux/states/trivia_state.dart';
import 'package:weekly_bible_trivia/redux/states/weekly_trivia_state.dart';

import 'authentication_state.dart';
import 'bottombar_state.dart';
import 'info_state.dart';
import 'local_storage_state.dart';

@immutable
class AppState {
  final LoadingState loadingState;
  final BottomBarState bottomBarState;
  final ReaderState readerState;
  final TriviaState triviaState;
  final PastTriviaState pastTriviaState;
  final WeeklyTriviaState weeklyTriviaState;
  final AuthenticationState authenticationState;
  final SignInState signInState;
  final SignUpState signUpState;
  final LocalStorageState localStorageState;
  final AppBarState appBarState;
  final InfoState infoTriviaState;
  final ThemeSettingsState themeSettingsState;
  final EditProfileState editProfileState;
  final TableResultsState tableResultsState;
  final SearchState searchState;


  const AppState({
    required this.loadingState,
    required this.bottomBarState,
    required this.readerState,
    required this.triviaState,
    required this.pastTriviaState,
    required this.weeklyTriviaState,
    required this.authenticationState,
    required this.signInState,
    required this.signUpState,
    required this.localStorageState,
    required this.appBarState,
    required this.infoTriviaState,
    required this.themeSettingsState,
    required this.editProfileState,
    required this.tableResultsState,
    required this.searchState,
  });



  factory AppState.initial() {
    return AppState(
      loadingState: LoadingState.initial(),
      bottomBarState: BottomBarState.initial(),
      readerState: ReaderState.initial(),
      triviaState: TriviaState.initial(),
      pastTriviaState: PastTriviaState.initial(),
      weeklyTriviaState: WeeklyTriviaState.initial(),
      authenticationState: AuthenticationState.initial(),
      signInState: SignInState.initial(),
      signUpState: SignUpState.initial(),
      localStorageState: LocalStorageState.initial(),
      appBarState: AppBarState.initial(),
      infoTriviaState: InfoState.initial(),
      themeSettingsState: ThemeSettingsState.initial(),
      editProfileState: EditProfileState.initial(),
      tableResultsState: TableResultsState.initial(),
      searchState: SearchState.initial(),
    );
  }

  AppState copyWith(
      {
        LoadingState? loadingState,
        BottomBarState? bottomBarState,
      ReaderState? readerState,
      TriviaState? triviaState,
        PastTriviaState? pastTriviaState,
        WeeklyTriviaState? weeklyTriviaState,
      AuthenticationState? authenticationState,
      SignInState? signInState,
      SignUpState? signUpState,
      LocalStorageState? localStorageState,
      AppBarState? appBarState,
      InfoState? infoTriviaState,
      ThemeSettingsState? themeSettingsState,
      EditProfileState? editProfileState,
      TableResultsState? tableResultsState,
      SearchState? searchState}) {
    return AppState(
      loadingState: loadingState ?? this.loadingState,
      bottomBarState: bottomBarState ?? this.bottomBarState,
      signUpState: signUpState ?? this.signUpState,
      authenticationState: authenticationState ?? this.authenticationState,
      triviaState: triviaState ?? this.triviaState,
      pastTriviaState: pastTriviaState ?? this.pastTriviaState,
      weeklyTriviaState: weeklyTriviaState ?? this.weeklyTriviaState,
      signInState: signInState ?? this.signInState,
      readerState: readerState ?? this.readerState,
      localStorageState: localStorageState ?? this.localStorageState,
      appBarState: appBarState ?? this.appBarState,
      infoTriviaState: infoTriviaState ?? this.infoTriviaState,
      themeSettingsState: themeSettingsState ?? this.themeSettingsState,
      editProfileState: editProfileState ?? this.editProfileState,
      tableResultsState: tableResultsState ?? this.tableResultsState,
      searchState: searchState ?? this.searchState,
    );
  }
}
