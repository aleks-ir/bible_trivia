import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/states/trivia_state.dart';

Reducer<TriviaState> triviaReducer = combineReducers([
  TypedReducer<TriviaState, UpdateIsPastTriviaAction>(_changeIsPastTrivia),
  TypedReducer<TriviaState, UpdateListQuestionsAction>(_changeListQuestions),
  TypedReducer<TriviaState, UpdateListSkipQuestionsAction>(_changeListSkipQuestions),
]);


TriviaState _changeIsPastTrivia(
    TriviaState prevState, UpdateIsPastTriviaAction action) {
  return prevState.copyWith(
    isPastTrivia: action.isPastTrivia,
  );
}

TriviaState _changeListQuestions(
    TriviaState prevState, UpdateListQuestionsAction action) {
  return prevState.copyWith(
    listQuestions: action.listQuestions,
  );
}


TriviaState _changeListSkipQuestions(
    TriviaState prevState, UpdateListSkipQuestionsAction action) {
  return prevState.copyWith(
    listSkipQuestions: action.listSkipQuestions,
  );
}