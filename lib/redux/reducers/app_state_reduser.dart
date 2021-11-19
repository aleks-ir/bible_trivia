import 'package:weekly_bible_trivia/redux/reducers/past_trivia_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/reader_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/signin_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/signup_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/tabs_reducer.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import 'authentication_reducer.dart';
import 'home_reducer.dart';
import 'local_storage_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      activeTab: tabsReducer(state.activeTab, action),
      homeState: homeReducer(state.homeState, action),
      readerState: readerReducer(state.readerState, action),
      pastTriviaState: pastTriviaReducer(state.pastTriviaState, action),
      authenticationState:
          authenticationReducer(state.authenticationState, action),
      signUpState: signUpReducer(state.signUpState, action),
      signInState: signInReducer(state.signInState, action),
      localStorageState: localStorageReducer(state.localStorageState, action),
  );
}
