import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/theme_settings_actions.dart';
import 'package:weekly_bible_trivia/redux/states/theme_settings.dart';

Reducer<ThemeSettingsState> themeSettingsReducer = combineReducers([
  TypedReducer<ThemeSettingsState, UpdateThemeSettingsAction>(
      _saveThemeSetting),
]);

ThemeSettingsState _saveThemeSetting(
    ThemeSettingsState prevState, UpdateThemeSettingsAction action) {
  return prevState.copyWith(
      primaryColor: action.primaryColor,
      secondaryColor: action.secondaryColor,
      cardColor: action.cardColor,
      appBarColor: action.appBarColor,
      shadowColor: action.shadowColor,
      textColor: action.textColor,
      iconColor: action.iconColor);
}
