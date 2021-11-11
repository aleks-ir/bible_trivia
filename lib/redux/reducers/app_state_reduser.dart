import 'package:weekly_bible_trivia/redux/reducers/past_trivia_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/reader_reducer.dart';
import 'package:weekly_bible_trivia/redux/reducers/tabs_reducer.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import 'authorization_reducer.dart';
import 'home_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    homeState: homeReducer(state.homeState, action),
    readerState: readerReducer(state.readerState, action),
    pastTriviaState: pastTriviaReducer(state.pastTriviaState, action),
    authorizationState: authorizationReducer(state.authorizationState, action),
    activeTab: tabsReducer(state.activeTab, action),
  );
}
