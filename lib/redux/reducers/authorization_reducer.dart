import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/autorization_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/home_actions.dart';
import 'package:weekly_bible_trivia/redux/states/authorization_state.dart';
import 'package:weekly_bible_trivia/redux/states/home_state.dart';

Reducer<AuthorizationState> authorizationReducer = combineReducers([
  TypedReducer<AuthorizationState, UpdateAuthorizationAction>(_doUpdateHomeAction),
]);


AuthorizationState _doUpdateHomeAction(
    AuthorizationState prevState, UpdateAuthorizationAction action) {
  return prevState.copyWith(
    isAuthorized: action.isAuthorized,
  );
}