import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/past_trivia_action.dart';
import 'package:weekly_bible_trivia/redux/states/past_trivia_state.dart';

Reducer<PastTriviaState> pastTriviaReducer = combineReducers([
  TypedReducer<PastTriviaState, SelectBookAction>(_changeSelectedBookAction),
  TypedReducer<PastTriviaState, UpdateListBooksAction>(_changeListBooksAction),
]);


PastTriviaState _changeSelectedBookAction(
    PastTriviaState prevState, SelectBookAction action) {
  return prevState.copyWith(
    selectedBook: action.newBook,
  );
}

PastTriviaState _changeListBooksAction(
    PastTriviaState prevState, UpdateListBooksAction action) {
  return prevState.copyWith(
    books: action.newBooks,
  );
}