import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/local_storage_actions.dart';
import 'package:weekly_bible_trivia/redux/states/local_storage_state.dart';

Reducer<LocalStorageState> localStorageReducer = combineReducers([
  TypedReducer<LocalStorageState, UpdateReaderBookNameAction>(_saveBookName),
  TypedReducer<LocalStorageState, UpdateReaderChapterAction>(_saveChapter),
  TypedReducer<LocalStorageState, UpdateTranslationIdAction>(_saveTranslationId),
  TypedReducer<LocalStorageState, UpdateLanguageAction>(_saveLanguage),
  TypedReducer<LocalStorageState, UpdateThemeAction>(_saveTheme),
  TypedReducer<LocalStorageState, UpdateNotificationAction>(_saveNotification),
  TypedReducer<LocalStorageState, UpdateFontSizeAction>(_saveFontSize),
]);

LocalStorageState _saveBookName(
    LocalStorageState prevState, UpdateReaderBookNameAction action) {
  return prevState.copyWith(
    bookName: action.bookName,
  );
}

LocalStorageState _saveChapter(
    LocalStorageState prevState, UpdateReaderChapterAction action) {
  return prevState.copyWith(
    chapter: action.chapter,
  );
}

LocalStorageState _saveTranslationId(
    LocalStorageState prevState, UpdateTranslationIdAction action) {
  return prevState.copyWith(
    translationId: action.translationId,
  );
}

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


LocalStorageState _saveNotification(
    LocalStorageState prevState, UpdateNotificationAction action) {
  return prevState.copyWith(
      isNotification: action.isNotification
  );
}


LocalStorageState _saveFontSize(
    LocalStorageState prevState, UpdateFontSizeAction action) {
  return prevState.copyWith(
      fontSize: action.fontSize,
  );
}



