import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weekly_bible_trivia/global/strings.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/models/app_theme.dart';
import 'package:weekly_bible_trivia/redux/actions/local_storage_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/theme_settings_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';



ThunkAction<AppState> saveLanguageThunk(Language language) {
  return (Store<AppState> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();;

    prefs.setString(LANGUAGE, language.toString());
    store.dispatch(UpdateLanguageAction(language));
  };
}

ThunkAction<AppState> saveThemeThunk(ThemeType theme) {
  return (Store<AppState> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();;

    prefs.setString(THEME, theme.toString());
    store.dispatch(UpdateThemeAction(theme));
  };
}

ThunkAction<AppState> saveFontSizeThunk(double fontSize) {
  return (Store<AppState> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();;

    prefs.setDouble(FONT_SIZE, fontSize);
    store.dispatch(UpdateFontSizeAction(fontSize));
  };
}

ThunkAction<AppState> createInitSettingsThunk() {
  return (Store<AppState> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String english = Language.english.toString();
    final String russian = Language.russian.toString();
    final String light = ThemeType.light.toString();
    final String dark = ThemeType.dark.toString();

    String language = prefs.getString(LANGUAGE) ?? english;
    if(language == english){
      store.dispatch(UpdateLanguageAction(Language.english));
    }else if(language == russian){
      store.dispatch(UpdateLanguageAction(Language.russian));
    }

    String theme = prefs.getString(THEME) ?? light;
    if(theme == light){
      store.dispatch(UpdateThemeAction(ThemeType.light));
      initTheme(store, ThemeType.light);
    }else if(theme == dark){
      store.dispatch(UpdateThemeAction(ThemeType.dark));
      initTheme(store, ThemeType.dark);
    }

    double fontSize = prefs.getDouble(FONT_SIZE) ?? 20;
    store.dispatch(UpdateFontSizeAction(fontSize));
  };
}

void initTheme(Store<AppState> store, ThemeType themeType){
  AppTheme theme;
  if (themeType == ThemeType.dark) {
    theme = selectTheme(ThemeType.dark);
  } else {
    theme = selectTheme(ThemeType.light);
  }
  store.dispatch(UpdateThemeSettingsAction(theme.primaryColor,
      theme.secondaryColor, theme.appBarColor, theme.shadowColor, theme.textColor));
}