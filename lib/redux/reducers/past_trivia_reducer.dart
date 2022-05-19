import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/past_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/states/past_trivia_state.dart';

Reducer<PastTriviaState> pastTriviaReducer = combineReducers([
  TypedReducer<PastTriviaState, UpdatePastTriviaBookNameAction>(_changeBook),
  TypedReducer<PastTriviaState, UpdatePastTriviaChapterAction>(_changeChapter),
  TypedReducer<PastTriviaState, UpdatePastTriviaDialogAction>(
      _changePastTriviaDialog),
  TypedReducer<PastTriviaState, UpdateWeeklyTriviaDialogAction>(
      _changeTriviaDialog),
  TypedReducer<PastTriviaState, UpdateBookImageUrlMapAction>(
      _changeImages),
  TypedReducer<PastTriviaState, UpdateListPastBookNamesAction>(_changeListPastBookNames),
  TypedReducer<PastTriviaState, UpdateMapCountPastChaptersAction>(_changeListCountPastChapters),
  TypedReducer<PastTriviaState, ResetTriviaDialogAction>(_reset),
]);

PastTriviaState _changeBook(
    PastTriviaState prevState, UpdatePastTriviaBookNameAction action) {
  return prevState.copyWith(
    bookName: action.bookName,
  );
}

PastTriviaState _changeChapter(
    PastTriviaState prevState, UpdatePastTriviaChapterAction action) {
  return prevState.copyWith(
    chapter: action.chapter,
  );
}

PastTriviaState _changePastTriviaDialog(
    PastTriviaState prevState, UpdatePastTriviaDialogAction action) {
  return prevState.copyWith(
    isShowPastTriviaDialog: action.isShowPastTriviaDialog,
  );
}


PastTriviaState _changeTriviaDialog(
    PastTriviaState prevState, UpdateWeeklyTriviaDialogAction action) {
  return prevState.copyWith(
    isShowWeeklyTriviaDialog: action.isShowWeeklyTriviaDialog,

  );
}

PastTriviaState _changeImages(
    PastTriviaState prevState, UpdateBookImageUrlMapAction action) {
  return prevState.copyWith(
    bookImageUrlMap: action.bookImageUrlMap,
  );
}

PastTriviaState _changeListPastBookNames(
    PastTriviaState prevState, UpdateListPastBookNamesAction action) {
  return prevState.copyWith(
    listPastBookNames: action.listPastBookNames,
  );
}

PastTriviaState _changeListCountPastChapters(
    PastTriviaState prevState, UpdateMapCountPastChaptersAction action) {
  return prevState.copyWith(
    mapCountPastChapters: action.mapCountPastChapters,
  );
}

PastTriviaState _reset(
    PastTriviaState prevState, ResetTriviaDialogAction action) {
  return prevState.copyWith(
      isShowPastTriviaDialog: action.isShowPastTriviaDialog,
      isShowWeeklyTriviaDialog: action.isShowWeeklyTriviaDialog,
      bookName: action.bookName,
      chapter: action.chapter);
}
