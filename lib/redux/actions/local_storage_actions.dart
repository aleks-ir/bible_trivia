

import 'package:weekly_bible_trivia/models/enums.dart';

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