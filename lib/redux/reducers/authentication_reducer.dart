import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/authentication_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/edit_profile_actions.dart';
import 'package:weekly_bible_trivia/redux/states/authentication_state.dart';

Reducer<AuthenticationState> authenticationReducer = combineReducers([
  TypedReducer<AuthenticationState, AuthSuccessfulAction>(_saveUserAfterSignUp),
  TypedReducer<AuthenticationState, UpdateAuthErrorAction>(_saveAuthError),
  TypedReducer<AuthenticationState, UpdateAuthStatusAction>(_changeAuthenticationStatus),
  TypedReducer<AuthenticationState, EditProfileSuccessfulAction>(_updateUserProfile),

]);

AuthenticationState _saveUserAfterSignUp(
    AuthenticationState prevState, AuthSuccessfulAction action) {
  return prevState.copyWith(
    user: action.user,
  );
}


AuthenticationState _saveAuthError(
    AuthenticationState prevState, UpdateAuthErrorAction action) {
  return prevState.copyWith(
    authError: action.authError,
  );
}


AuthenticationState _changeAuthenticationStatus(
    AuthenticationState prevState, UpdateAuthStatusAction action) {
  return prevState.copyWith(
    status: action.status,
  );
}

AuthenticationState _updateUserProfile(
    AuthenticationState prevState, EditProfileSuccessfulAction action) {
  return prevState.copyWith(
    user: action.user,
  );
}


