import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/redux/actions/profile_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/edit_profile_state.dart';

Reducer<EditProfileState> editProfileReducer = combineReducers([
  TypedReducer<EditProfileState, UpdateLoadingAction>(
      _changeLoadingStatus),
  TypedReducer<EditProfileState, ChangeValidationStatusAction>(
      _changeValidationStatus),
  TypedReducer<EditProfileState, NameErrorAction>(_changeNameError),
  TypedReducer<EditProfileState, ClearSignInErrorsAction>(_clearErrorsAction)
]);

EditProfileState _changeLoadingStatus(
    EditProfileState prevState, UpdateLoadingAction action) {
  return prevState.copyWith(
    loading: action.loading,
  );
}

EditProfileState _changeValidationStatus(
    EditProfileState state, ChangeValidationStatusAction action) =>
    state.copyWith(validationStatus: action.status);

EditProfileState _changeNameError(EditProfileState state, NameErrorAction action) {
  if (action.screen == Screen.editProfile) {
    return state.copyWith(
        nameError: action.message);
  } else {
    return state;
  }
}

EditProfileState _clearErrorsAction(EditProfileState state, ClearSignInErrorsAction action) =>
    state.copyWith(validationStatus: ValidationStatus.success, nameError: "");