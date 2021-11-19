import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/models/validation_status.dart';
import 'package:weekly_bible_trivia/models/screens.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/home_actions.dart';
import 'package:weekly_bible_trivia/redux/states/home_state.dart';
import 'package:weekly_bible_trivia/redux/states/signin_state.dart';
import 'package:weekly_bible_trivia/redux/states/signup_state.dart';

Reducer<SignInState> signInReducer = combineReducers([
  TypedReducer<SignInState, ChangeValidationStatusAction>(
      _changeValidationStatusAction),
  TypedReducer<SignInState, EmailErrorAction>(_emailErrorAction),
  TypedReducer<SignInState, PasswordErrorAction>(_passwordErrorAction),
  TypedReducer<SignInState, ClearErrorsAction>(_clearErrorsAction)
]);

SignInState _changeValidationStatusAction(
    SignInState state, ChangeValidationStatusAction action) =>
    state.copyWith(validationStatus: action.status);

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

SignInState _clearErrorsAction(SignInState state, ClearErrorsAction action) =>
    state.copyWith(validationStatus: ValidationStatus.success, emailError: "", passwordError: "");