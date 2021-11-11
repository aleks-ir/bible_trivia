import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/home_actions.dart';
import 'package:weekly_bible_trivia/redux/states/home_state.dart';

Reducer<HomeState> homeReducer = combineReducers([
  TypedReducer<HomeState, UpdateHomeTitleAction>(_doUpdateHomeAction),
]);


HomeState _doUpdateHomeAction(
    HomeState prevState, UpdateHomeTitleAction action) {
  return prevState.copyWith(
    title: action.title,
  );
}