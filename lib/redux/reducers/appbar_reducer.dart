import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/states/appbar_state.dart';

Reducer<AppBarState> appBarReducer = combineReducers([
  TypedReducer<AppBarState, UpdateShowMenuBarAction>(_changeShowMenuBarAction),
  TypedReducer<AppBarState, UpdateMenuBarAction>(_changeMenuBarAction),
]);


AppBarState _changeShowMenuBarAction(
    AppBarState prevState, UpdateShowMenuBarAction action) {
  return prevState.copyWith(
    isShowMenuBar: action.isShowMenuBar,
  );
}

AppBarState _changeMenuBarAction(
    AppBarState prevState, UpdateMenuBarAction action) {
  return prevState.copyWith(
    menuBar: action.newMenuBar,
  );
}
