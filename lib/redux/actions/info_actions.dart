class UpdateInfoTriviaBookAction {
  final String bookName;
  UpdateInfoTriviaBookAction(this.bookName);
}

class UpdateInfoTriviaChaptersAction {
  final String chapters;
  UpdateInfoTriviaChaptersAction(this.chapters);
}

class UpdateInfoTriviaDateAction {
  final DateTime date;
  UpdateInfoTriviaDateAction(this.date);
}

class UpdateCurrentDateAction {
  final DateTime currentDate;
  UpdateCurrentDateAction(this.currentDate);
}

class UpdateListPastBookNamesAction {
  final List<String> listPastBookNames;
  UpdateListPastBookNamesAction(this.listPastBookNames);
}

class UpdateMapCountPastChaptersAction {
  final Map<String, int> mapCountPastChapters;
  UpdateMapCountPastChaptersAction(this.mapCountPastChapters);
}