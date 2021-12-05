import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/bottombar_state.dart';

final bottomBarReducer = combineReducers<BottomBarState>([
  TypedReducer<BottomBarState, UpdateNavigationTabAction>(_activeTabReducer),
]);


BottomBarState _activeTabReducer(
    BottomBarState prevState, UpdateNavigationTabAction action) {
  return prevState.copyWith(
      activeTab: action.newTab
  );
}