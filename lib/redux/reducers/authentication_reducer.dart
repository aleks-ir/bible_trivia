import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/authentication_action.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/authentication_state.dart';

Reducer<AuthenticationState> authenticationReducer = combineReducers([
  TypedReducer<AuthenticationState, AuthSuccessfulAction>(_saveUserAfterSignUp),
  TypedReducer<AuthenticationState, AuthErrorAction>(_saveAuthError),
  TypedReducer<AuthenticationState, ChangeAuthStatusAction>(_changeAuthenticationStatus),
]);

AuthenticationState _saveUserAfterSignUp(
    AuthenticationState prevState, AuthSuccessfulAction action) {
  return prevState.copyWith(
    user: action.user,
  );
}


AuthenticationState _saveAuthError(
    AuthenticationState prevState, AuthErrorAction action) {
  return prevState.copyWith(
    authError: action.authError,
  );
}


AuthenticationState _changeAuthenticationStatus(
    AuthenticationState prevState, ChangeAuthStatusAction action) {
  return prevState.copyWith(
    status: action.status,
  );
}


