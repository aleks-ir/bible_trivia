import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/states/appbar_state.dart';

Reducer<AppBarState> appBarReducer = combineReducers([
  TypedReducer<AppBarState, UpdateShowMenuBarAction>(_changeShowMenuBarAction),
  TypedReducer<AppBarState, UpdateReaderModAction>(_changeReaderModAction),
  TypedReducer<AppBarState, UpdateMenuBarAction>(_changeMenuBarAction),
  TypedReducer<AppBarState, UpdateTestamentAction>(_changeTestamentAction),
]);


AppBarState _changeTestamentAction(
    AppBarState prevState, UpdateTestamentAction action) {
  return prevState.copyWith(
    isOldTestament: action.isOldTestament,
  );
}

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

AppBarState _changeReaderModAction(
    AppBarState prevState, UpdateReaderModAction action) {
  return prevState.copyWith(
    isReaderMod: action.isReaderMod,
  );
}
