import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/models/loading_status.dart';
import 'package:weekly_bible_trivia/models/screens.dart';
import 'package:weekly_bible_trivia/redux/actions/authentication_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/home_actions.dart';
import 'package:weekly_bible_trivia/redux/states/home_state.dart';
import 'package:weekly_bible_trivia/redux/states/signin_state.dart';
import 'package:weekly_bible_trivia/redux/states/signup_state.dart';

Reducer<SignInState> signInReducer = combineReducers([
  TypedReducer<SignInState, ChangeLoadingStatusAction>(
      _changeLoadingStatusAction),
  TypedReducer<SignInState, EmailErrorAction>(_emailErrorAction),
  TypedReducer<SignInState, PasswordErrorAction>(_passwordErrorAction),
  TypedReducer<SignInState, SignInAction>(_signInAction),
  TypedReducer<SignInState, ClearErrorsAction>(_clearErrorsAction)
]);

SignInState _changeLoadingStatusAction(
    SignInState state, ChangeLoadingStatusAction action) =>
    state.copyWith(loadingStatus: action.status);

SignInState _emailErrorAction(SignInState state, EmailErrorAction action) {
  if (action.screen == Screens.SIGNIN) {
    return state.copyWith(
        emailError: action.message);
  } else {
    return state;
  }
}

SignInState _passwordErrorAction(
    SignInState state, PasswordErrorAction action) {
  if (action.screen == Screens.SIGNIN) {
    return state.copyWith(passwordError: action.message);
  } else {
    return state;
  }
}

SignInState _signInAction(SignInState state, SignInAction action) => state;

SignInState _clearErrorsAction(SignInState state, ClearErrorsAction action) =>
    state.copyWith(loadingStatus: LoadingStatus.success, emailError: "", passwordError: "");