import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/redux/actions/edit_profile_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/edit_profile_state.dart';

Reducer<EditProfileState> editProfileReducer = combineReducers([
  TypedReducer<EditProfileState, UpdateLoadingAction>(
      _changeLoadingStatus),
  TypedReducer<EditProfileState, ChangeValidationStatusAction>(
      _changeValidationStatusAction),
  TypedReducer<EditProfileState, NameErrorAction>(_nameErrorAction),
  TypedReducer<EditProfileState, ClearErrorsAction>(_clearErrorsAction)
]);

EditProfileState _changeLoadingStatus(
    EditProfileState prevState, UpdateLoadingAction action) {
  return prevState.copyWith(
    loading: action.loading,
  );
}

EditProfileState _changeValidationStatusAction(
    EditProfileState state, ChangeValidationStatusAction action) =>
    state.copyWith(validationStatus: action.status);

EditProfileState _nameErrorAction(EditProfileState state, NameErrorAction action) {
  if (action.screen == Screen.editProfile) {
    return state.copyWith(
        nameError: action.message);
  } else {
    return state;
  }
}

EditProfileState _clearErrorsAction(EditProfileState state, ClearErrorsAction action) =>
    state.copyWith(validationStatus: ValidationStatus.success, nameError: "");