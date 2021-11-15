import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/models/loading_status.dart';
import 'package:weekly_bible_trivia/models/screens.dart';
import 'package:weekly_bible_trivia/redux/actions/authentication_actions.dart';
import 'package:weekly_bible_trivia/redux/states/signup_state.dart';

Reducer<SignUpState> signUpReducer = combineReducers([
  TypedReducer<SignUpState, ChangeLoadingStatusAction>(
      _changeLoadingStatusAction),
  TypedReducer<SignUpState, NameErrorAction>(_nameErrorAction),
  TypedReducer<SignUpState, EmailErrorAction>(_emailErrorAction),
  TypedReducer<SignUpState, PasswordErrorAction>(_passwordErrorAction),
  TypedReducer<SignUpState, RetypePasswordErrorAction>(
      _retypePasswordErrorAction),
  TypedReducer<SignUpState, SignUpAction>(_signUpAction),
  TypedReducer<SignUpState, ClearErrorsAction>(_clearErrorsAction)
]);

SignUpState _changeLoadingStatusAction(
        SignUpState state, ChangeLoadingStatusAction action) =>
    state.copyWith(loadingStatus: action.status);

SignUpState _nameErrorAction(SignUpState state, NameErrorAction action) {
  if (action.screen == Screens.SIGNUP) {
    return state.copyWith(
        nameError: action.message);
  } else {
    return state;
  }
}

SignUpState _emailErrorAction(SignUpState state, EmailErrorAction action) {
  if (action.screen == Screens.SIGNUP) {
    return state.copyWith(
        emailError: action.message);
  } else {
    return state;
  }
}

SignUpState _passwordErrorAction(
    SignUpState state, PasswordErrorAction action) {
  if (action.screen == Screens.SIGNUP) {
    return state.copyWith(passwordError: action.message);
  } else {
    return state;
  }
}

SignUpState _retypePasswordErrorAction(
    SignUpState state, RetypePasswordErrorAction action) {
  if (action.screen == Screens.SIGNUP) {
    return state.copyWith(retypePasswordError: action.message);
  } else {
    return state;
  }
}

SignUpState _signUpAction(SignUpState state, SignUpAction action) => state;

SignUpState _clearErrorsAction(SignUpState state, ClearErrorsAction action) =>
    state.copyWith(loadingStatus: LoadingStatus.success, nameError: "", emailError: "", passwordError: "", retypePasswordError: "");