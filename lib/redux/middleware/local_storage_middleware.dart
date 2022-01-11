import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/models/app_theme.dart';
import 'package:weekly_bible_trivia/redux/actions/loading_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/local_storage_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/search_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/theme_settings_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';

ThunkAction<AppState> saveBookNameThunk(String bookName) {
  return (Store<AppState> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ;

    prefs.setString(BOOK_NAME, bookName);
    store.dispatch(UpdateReaderBookNameAction(bookName));
  };
}

ThunkAction<AppState> saveChapterThunk(int chapter) {
  return (Store<AppState> store) async {
    store.dispatch(UpdateSearchVerseAction(0));
    SharedPreferences prefs = await SharedPreferences.getInstance();


    prefs.setInt(CHAPTER, chapter);
    store.dispatch(UpdateReaderChapterAction(chapter));
  };
}

ThunkAction<AppState> saveTranslationIdThunk(String translation) {
  return (Store<AppState> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ;

    prefs.setString(TRARSLATION_ID, translation);
    store.dispatch(UpdateTranslationIdAction(translation));
  };
}

ThunkAction<AppState> saveDBHasDataThunk(bool hasData) {
  return (Store<AppState> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ;
    prefs.setBool(DB_HAS_DATA, hasData);
  };
}

ThunkAction<AppState> saveLanguageThunk(String language) {
  return (Store<AppState> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ;

    prefs.setString(LANGUAGE, language.toString());
    store.dispatch(UpdateLanguageAction(language));
  };
}

ThunkAction<AppState> saveThemeThunk(String theme) {
  return (Store<AppState> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ;

    prefs.setString(THEME, theme.toString());
    store.dispatch(UpdateThemeAction(theme));
  };
}

ThunkAction<AppState> saveFontSizeThunk(double fontSize) {
  return (Store<AppState> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ;

    prefs.setDouble(FONT_SIZE, fontSize);
    store.dispatch(UpdateFontSizeAction(fontSize));
  };
}

ThunkAction<AppState> initSettingsThunk() {
  return (Store<AppState> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String bookName = prefs.getString(BOOK_NAME) ?? DEFAULT_BOOK_NAME;
    store.dispatch(UpdateReaderBookNameAction(bookName));

    int chapter = prefs.getInt(CHAPTER) ?? DEFAULT_CHAPTER;
    store.dispatch(UpdateReaderChapterAction(chapter));

    String translationId =
        prefs.getString(TRARSLATION_ID) ?? DEFAULT_TRARSLATION_ID;
    store.dispatch(UpdateTranslationIdAction(translationId));

    String language = prefs.getString(LANGUAGE) ?? ENGLISH;
    store.dispatch(UpdateLanguageAction(language));

    String theme = prefs.getString(THEME) ?? LIGHT;
    store.dispatch(UpdateThemeAction(theme));
    initTheme(store, theme);

    double fontSize = prefs.getDouble(FONT_SIZE) ?? DEFAULT_FONT_SIZE;
    store.dispatch(UpdateFontSizeAction(fontSize));

    Future.delayed(const Duration(seconds: 2), () async {
      store.dispatch(LoadedAppAction());
    });
  };
}

void initTheme(Store<AppState> store, String themeType) async {
  AppTheme theme = selectTheme(themeType);
  store.dispatch(UpdateThemeSettingsAction(
      theme.primaryColor,
      theme.secondaryColor,
      theme.cardColor,
      theme.appBarColor,
      theme.shadowColor,
      theme.textColor,
      theme.iconColor));
}
