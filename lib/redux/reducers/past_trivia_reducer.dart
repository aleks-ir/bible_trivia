import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/past_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/states/past_trivia_state.dart';

Reducer<PastTriviaState> pastTriviaReducer = combineReducers([
  TypedReducer<PastTriviaState, UpdatePastTriviaBookNameAction>(_changeBook),
  TypedReducer<PastTriviaState, UpdatePastTriviaChapterAction>(_changeChapter),
  TypedReducer<PastTriviaState, UpdatePastTriviaDialogAction>(
      _changeShowDialog),
  TypedReducer<PastTriviaState, ResetPastTriviaAction>(_reset),
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

PastTriviaState _changeShowDialog(
    PastTriviaState prevState, UpdatePastTriviaDialogAction action) {
  return prevState.copyWith(
    isShowDialog: action.isShowDialog,
  );
}

PastTriviaState _reset(
    PastTriviaState prevState, ResetPastTriviaAction action) {
  return prevState.copyWith(
      isShowDialog: action.isShowDialog,
      bookName: action.bookName,
      chapter: action.chapter);
}
