import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/authentication_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/home_actions.dart';
import 'package:weekly_bible_trivia/redux/states/authentication_state.dart';
import 'package:weekly_bible_trivia/redux/states/home_state.dart';

Reducer<AuthenticationState> authorizationReducer = combineReducers([
  TypedReducer<AuthenticationState, UpdateAuthorizationAction>(_doUpdateHomeAction),
]);


AuthenticationState _doUpdateHomeAction(
    AuthenticationState prevState, UpdateAuthorizationAction action) {
  return prevState.copyWith(
    isAuthorized: action.isAuthorized,
  );
}