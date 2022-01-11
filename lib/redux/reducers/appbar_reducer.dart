import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/states/appbar_state.dart';

Reducer<AppBarState> appBarReducer = combineReducers([
  TypedReducer<AppBarState, UpdateShowMenuBarAction>(_changeShowMenuBar),
  TypedReducer<AppBarState, UpdateReaderModAction>(_changeReaderMod),
  TypedReducer<AppBarState, UpdateMenuBarAction>(_changeMenuBar),
  TypedReducer<AppBarState, UpdateTestamentAction>(_changeTestament),
]);


AppBarState _changeTestament(
    AppBarState prevState, UpdateTestamentAction action) {
  return prevState.copyWith(
    isOldTestament: action.isOldTestament,
  );
}

AppBarState _changeShowMenuBar(
    AppBarState prevState, UpdateShowMenuBarAction action) {
  return prevState.copyWith(
    isShowMenuBar: action.isShowMenuBar,
  );
}

AppBarState _changeMenuBar(
    AppBarState prevState, UpdateMenuBarAction action) {
  return prevState.copyWith(
    menuBar: action.newMenuBar,
  );
}

AppBarState _changeReaderMod(
    AppBarState prevState, UpdateReaderModAction action) {
  return prevState.copyWith(
    isReaderMod: action.isReaderMod,
  );
}
