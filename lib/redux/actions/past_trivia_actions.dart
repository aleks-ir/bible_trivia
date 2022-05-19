

class UpdatePastTriviaBookNameAction {
  final String bookName;
  UpdatePastTriviaBookNameAction(this.bookName);
}

class UpdatePastTriviaChapterAction {
  final int chapter;
  UpdatePastTriviaChapterAction(this.chapter);
}

class UpdatePastTriviaDialogAction {
  final bool isShowPastTriviaDialog;
  UpdatePastTriviaDialogAction(this.isShowPastTriviaDialog);
}

class UpdateWeeklyTriviaDialogAction {
  final bool isShowWeeklyTriviaDialog;
  UpdateWeeklyTriviaDialogAction(this.isShowWeeklyTriviaDialog);
}


class UpdateBookImageUrlMapAction {
  final Map<String, String> bookImageUrlMap;
  UpdateBookImageUrlMapAction(this.bookImageUrlMap);
}

class UpdateListPastBookNamesAction {
  final List<String> listPastBookNames;
  UpdateListPastBookNamesAction(this.listPastBookNames);
}

class UpdateMapCountPastChaptersAction {
  final Map<String, int> mapCountPastChapters;
  UpdateMapCountPastChaptersAction(this.mapCountPastChapters);
}

class ResetTriviaDialogAction {
  final bool isShowPastTriviaDialog = false;
  final bool isShowWeeklyTriviaDialog = false;
  final String bookName = "";
  final int chapter = -1;
  ResetTriviaDialogAction();
}
