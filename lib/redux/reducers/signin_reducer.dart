import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/signin_state.dart';

Reducer<SignInState> signInReducer = combineReducers([
  TypedReducer<SignInState, ChangeValidationStatusAction>(
      _changeValidationStatusAction),
  TypedReducer<SignInState, EmailErrorAction>(_changeError),
  TypedReducer<SignInState, PasswordErrorAction>(_changePasswordError),
  TypedReducer<SignInState, ClearErrorsAction>(_clearErrors)
]);

SignInState _changeValidationStatusAction(
    SignInState state, ChangeValidationStatusAction action) =>
    state.copyWith(validationStatus: action.status);

SignInState _changeError(SignInState state, EmailErrorAction action) {
  if (action.screen == Screen.signin) {
    return state.copyWith(
        emailError: action.message);
  } else {
    return state;
  }
}

SignInState _changePasswordError(
    SignInState state, PasswordErrorAction action) {
  if (action.screen == Screen.signin) {
    return state.copyWith(passwordError: action.message);
  } else {
    return state;
  }
}

SignInState _clearErrors(SignInState state, ClearErrorsAction action) =>
    state.copyWith(validationStatus: ValidationStatus.success, emailError: "", passwordError: "");