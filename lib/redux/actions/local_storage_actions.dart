import 'package:weekly_bible_trivia/constants/enums/languages.dart';
import 'package:weekly_bible_trivia/constants/enums/themes.dart';

class UpdateLanguageAction {
  final Languages language;
  UpdateLanguageAction(this.language);
}

class UpdateThemeAction {
  final Themes theme;
  UpdateThemeAction(this.theme);
}

class UpdateFontSizeAction {
  final double fontSize;
  UpdateFontSizeAction(this.fontSize);
}