import 'package:weekly_bible_trivia/redux/reducers/appbar_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/bottombar_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/past_trivia_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/reader_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/search_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/signin_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/signup_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/table_results_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/theme_settings_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/trivia_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/weekly_trivia_reducer.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import 'appbar_reducer.dart';
import 'authentication_reducer.dart';
import 'edit_profile_reducer.dart';
import 'info_reducer.dart';
import 'loading_reducer.dart';
import 'local_storage_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      loadingState: loadingReducer(state.loadingState, action),
      readerState: readerReducer(state.readerState, action),
      triviaState: triviaReducer(state.triviaState, action),
      pastTriviaState: pastTriviaReducer(state.pastTriviaState, action),
      weeklyTriviaState: weeklyTriviaReducer(state.weeklyTriviaState, action),
      authenticationState:
          authenticationReducer(state.authenticationState, action),
      signUpState: signUpReducer(state.signUpState, action),
      signInState: signInReducer(state.signInState, action),
      localStorageState: localStorageReducer(state.localStorageState, action),
      appBarState: appBarReducer(state.appBarState, action),
      bottomBarState: bottomBarReducer(state.bottomBarState, action),
      infoTriviaState: infoReducer(state.infoTriviaState, action),
      themeSettingsState: themeSettingsReducer(state.themeSettingsState, action),
      editProfileState: editProfileReducer(state.editProfileState, action),
      tableResultsState: tableResultsReducer(state.tableResultsState, action),
      searchState: searchReducer(state.searchState, action),
  );
}
