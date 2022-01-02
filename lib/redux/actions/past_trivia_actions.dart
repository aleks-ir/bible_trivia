
class UpdatePastTriviaBookNameAction {
  final String bookName;
  UpdatePastTriviaBookNameAction(this.bookName);
}

class UpdatePastTriviaChapterAction {
  final int chapter;
  UpdatePastTriviaChapterAction(this.chapter);
}

class UpdatePastTriviaDialogAction {
  final bool isShowDialog;
  UpdatePastTriviaDialogAction(this.isShowDialog);
}

class ResetPastTriviaAction {
  final bool isShowDialog = false;
  final String bookName = "";
  final int chapter = -1;
  ResetPastTriviaAction();
}
