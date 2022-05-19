import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/bottombar_state.dart';

final bottomBarReducer = combineReducers<BottomBarState>([
  TypedReducer<BottomBarState, UpdateNavigationTabAction>(_activeTabReducer),
  TypedReducer<BottomBarState, UpdateActiveAnimation>(_changeActiveAnimationReducer),
]);


BottomBarState _activeTabReducer(
    BottomBarState prevState, UpdateNavigationTabAction action) {
  return prevState.copyWith(
      activeTab: action.newTab

  );
}

BottomBarState _changeActiveAnimationReducer(
    BottomBarState prevState, UpdateActiveAnimation action) {
  return prevState.copyWith(
      isActiveAnimation: action.isActiveAnimation

  );
}