

class UpdateBookNameAction {
  final String bookName;
  UpdateBookNameAction(this.bookName);
}

class UpdateDisplayBookNameAction {
  final String displayBookName;
  UpdateDisplayBookNameAction(this.displayBookName);
}

class UpdateChapterAction {
  final int chapter;
  UpdateChapterAction(this.chapter);
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