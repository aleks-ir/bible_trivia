

class UpdateReaderBookNameAction {
  final String bookName;
  UpdateReaderBookNameAction(this.bookName);
}

class UpdateReaderChapterAction {
  final int chapter;
  UpdateReaderChapterAction(this.chapter);
}

class UpdateTranslationIdAction {
  final String translationId;
  UpdateTranslationIdAction(this.translationId);
}


class UpdateLanguageAction {
  final String language;
  UpdateLanguageAction(this.language);
}

class UpdateThemeAction {
  final String theme;
  UpdateThemeAction(this.theme);
}

class UpdateFontSizeAction {
  final double fontSize;
  UpdateFontSizeAction(this.fontSize);
}