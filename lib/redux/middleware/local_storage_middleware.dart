import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weekly_bible_trivia/constants/enums/languages.dart';
import 'package:weekly_bible_trivia/constants/enums/themes.dart';
import 'package:weekly_bible_trivia/constants/strings.dart';
import 'package:weekly_bible_trivia/redux/actions/local_storage_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';



ThunkAction<AppState> saveLanguageThunk(Languages language) {
  return (Store<AppState> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();;

    prefs.setString(LANGUAGE, language.toString());
    store.dispatch(UpdateLanguageAction(language));
  };
}

ThunkAction<AppState> saveThemeThunk(Themes theme) {
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
    final String english = Languages.english.toString();
    final String russian = Languages.russian.toString();
    final String light = Themes.light.toString();
    final String dark = Themes.dark.toString();

    String language = prefs.getString(LANGUAGE) ?? english;
    if(language == english){
      store.dispatch(UpdateLanguageAction(Languages.english));
    }else if(language == russian){
      store.dispatch(UpdateLanguageAction(Languages.russian));
    }

    String theme = prefs.getString(THEME) ?? light;
    if(theme == light){
      store.dispatch(UpdateThemeAction(Themes.light));
    }else if(theme == dark){
      store.dispatch(UpdateThemeAction(Themes.dark));
    }

    double fontSize = prefs.getDouble(FONT_SIZE) ?? 20;
    store.dispatch(UpdateFontSizeAction(fontSize));
  };
}