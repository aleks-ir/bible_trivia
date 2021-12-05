

import 'package:weekly_bible_trivia/global/enums.dart';

class UpdateLanguageAction {
  final Language language;
  UpdateLanguageAction(this.language);
}

class UpdateThemeAction {
  final ThemeType theme;
  UpdateThemeAction(this.theme);
}

class UpdateFontSizeAction {
  final double fontSize;
  UpdateFontSizeAction(this.fontSize);
}