import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/states/trivia_state.dart';

Reducer<TriviaState> triviaReducer = combineReducers([
  TypedReducer<TriviaState, UpdateTriviaDialogAction>(_changeTriviaDialogTrivia),
  TypedReducer<TriviaState, UpdateIsTimeTriviaAction>(_changeIsPastTrivia),
  TypedReducer<TriviaState, UpdateCurrentPageAction>(_changeCurrentPage),
  TypedReducer<TriviaState, UpdateStartPageAction>(_changeStartPage),
  TypedReducer<TriviaState, UpdateEndPageAction>(_changeEndPage),
  TypedReducer<TriviaState, UpdateTriviaQuestionsAction>(_changeQuestions),
  TypedReducer<TriviaState, UpdateListCurrentAnswersAction>(_changeListAnswers),
  TypedReducer<TriviaState, UpdateListAnsweredQuestionsAction>(_changeListSkipQuestions),
]);

TriviaState _changeTriviaDialogTrivia(
    TriviaState prevState, UpdateTriviaDialogAction action) {
  return prevState.copyWith(
    isShowDialog: action.isShowDialog,
  );
}

TriviaState _changeIsPastTrivia(
    TriviaState prevState, UpdateIsTimeTriviaAction action) {
  return prevState.copyWith(
    isTimeTrivia: action.isTimeTrivia,
  );
}


TriviaState _changeCurrentPage(
    TriviaState prevState, UpdateCurrentPageAction action) {
  return prevState.copyWith(
    currentPage: action.currentPage,
  );
}

TriviaState _changeStartPage(
    TriviaState prevState, UpdateStartPageAction action) {
  return prevState.copyWith(
    startPage: action.startPage,
  );
}

TriviaState _changeEndPage(
    TriviaState prevState, UpdateEndPageAction action) {
  return prevState.copyWith(
    endPage: action.endPage,
  );
}

TriviaState _changeQuestions(
    TriviaState prevState, UpdateTriviaQuestionsAction action) {
  return prevState.copyWith(
    questions: action.questions,
  );
}

TriviaState _changeListAnswers(
    TriviaState prevState, UpdateListCurrentAnswersAction action) {
  return prevState.copyWith(
    currentAnswers: action.listCurrentAnswers,
  );
}


TriviaState _changeListSkipQuestions(
    TriviaState prevState, UpdateListAnsweredQuestionsAction action) {
  return prevState.copyWith(
    answeredQuestions: action.listAnsweredQuestions,
  );
}