import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/authentication_action.dart';
import 'package:weekly_bible_trivia/redux/actions/local_storage_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/authentication_state.dart';
import 'package:weekly_bible_trivia/redux/states/local_storage_state.dart';

Reducer<LocalStorageState> localStorageReducer = combineReducers([
  TypedReducer<LocalStorageState, TokenAction>(_saveToken),
]);

LocalStorageState _saveToken(
    LocalStorageState prevState, TokenAction action) {
  return prevState.copyWith(
    token: action.token,
  );
}


