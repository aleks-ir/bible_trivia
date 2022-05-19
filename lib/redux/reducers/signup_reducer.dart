import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/signup_state.dart';

Reducer<SignUpState> signUpReducer = combineReducers([
  TypedReducer<SignUpState, ChangeValidationStatusAction>(
      _changeValidationStatus),
  TypedReducer<SignUpState, NameErrorAction>(_nameError),
  TypedReducer<SignUpState, EmailErrorAction>(_emailError),
  TypedReducer<SignUpState, PasswordErrorAction>(_passwordError),
  TypedReducer<SignUpState, RetypePasswordErrorAction>(
      _retypePasswordError),
  TypedReducer<SignUpState, ClearSignUpErrorsAction>(_clearErrors)
]);

SignUpState _changeValidationStatus(
        SignUpState state, ChangeValidationStatusAction action) =>
    state.copyWith(validationStatus: action.status);

SignUpState _nameError(SignUpState state, NameErrorAction action) {
  if (action.screen == Screen.signup) {
    return state.copyWith(nameError: action.message);
  } else {
    return state;
  }
}

SignUpState _emailError(SignUpState state, EmailErrorAction action) {
  if (action.screen == Screen.signup) {
    return state.copyWith(emailError: action.message);
  } else {
    return state;
  }
}

SignUpState _passwordError(
    SignUpState state, PasswordErrorAction action) {
  if (action.screen == Screen.signup) {
    return state.copyWith(passwordError: action.message);
  } else {
    return state;
  }
}

SignUpState _retypePasswordError(
    SignUpState state, RetypePasswordErrorAction action) {
  if (action.screen == Screen.signup) {
    return state.copyWith(retypePasswordError: action.message);
  } else {
    return state;
  }
}

SignUpState _clearErrors(SignUpState state, ClearSignUpErrorsAction action) =>
    state.copyWith(
        validationStatus: ValidationStatus.loading,
        nameError: "",
        emailError: "",
        passwordError: "",
        retypePasswordError: "");
