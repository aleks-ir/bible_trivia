import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/weekly_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/states/weekly_trivia_state.dart';

Reducer<WeeklyTriviaState> weeklyTriviaReducer = combineReducers([
  TypedReducer<WeeklyTriviaState, UpdateWeeklyTriviaDateAction>(_changeDate),
  TypedReducer<WeeklyTriviaState, UpdateRuntimeAction>(_changeRuntime),
  TypedReducer<WeeklyTriviaState, UpdateWeeklyTriviaPassedAction>(
      _changeShowDialog),
  TypedReducer<WeeklyTriviaState, UpdateAccessWeeklyTriviaAction>(_changeAccessTrivia),
  TypedReducer<WeeklyTriviaState, AccessWeeklyTriviaErrorAction>(
      _changeAccessError),
  TypedReducer<WeeklyTriviaState, UpdateWeeklyTriviaQuestionsAction>(
      _changeQuestions),
]);

WeeklyTriviaState _changeDate(
    WeeklyTriviaState prevState, UpdateWeeklyTriviaDateAction action) {
  return prevState.copyWith(
    date: action.date,
  );
}

WeeklyTriviaState _changeRuntime(
    WeeklyTriviaState prevState, UpdateRuntimeAction action) {
  return prevState.copyWith(
    runtime: action.runtime,
  );
}

WeeklyTriviaState _changeShowDialog(
    WeeklyTriviaState prevState, UpdateWeeklyTriviaPassedAction action) {
  return prevState.copyWith(
    isPassed: action.isPassed,
  );
}


WeeklyTriviaState _changeAccessTrivia(
    WeeklyTriviaState prevState, UpdateAccessWeeklyTriviaAction action) {
  return prevState.copyWith(
    isAccessTrivia: action.isAccessTrivia,
  );
}

WeeklyTriviaState _changeAccessError(
    WeeklyTriviaState prevState, AccessWeeklyTriviaErrorAction action) {
  return prevState.copyWith(
    messageError: action.message,
  );
}

WeeklyTriviaState _changeQuestions(
    WeeklyTriviaState prevState, UpdateWeeklyTriviaQuestionsAction action) {
  return prevState.copyWith(
    questions: action.questions,
  );
}

