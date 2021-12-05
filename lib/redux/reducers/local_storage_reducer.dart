import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/local_storage_actions.dart';
import 'package:weekly_bible_trivia/redux/states/local_storage_state.dart';

Reducer<LocalStorageState> localStorageReducer = combineReducers([
  TypedReducer<LocalStorageState, UpdateLanguageAction>(_saveLanguage),
  TypedReducer<LocalStorageState, UpdateThemeAction>(_saveTheme),
  TypedReducer<LocalStorageState, UpdateFontSizeAction>(_saveFontSize),
]);

LocalStorageState _saveLanguage(
    LocalStorageState prevState, UpdateLanguageAction action) {
  return prevState.copyWith(
      language: action.language,
  );
}

LocalStorageState _saveTheme(
    LocalStorageState prevState, UpdateThemeAction action) {
  return prevState.copyWith(
      theme: action.theme
  );
}

LocalStorageState _saveFontSize(
    LocalStorageState prevState, UpdateFontSizeAction action) {
  return prevState.copyWith(
      fontSize: action.fontSize,
  );
}


