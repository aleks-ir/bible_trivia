import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/weekly_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/states/weekly_trivia_state.dart';

Reducer<WeeklyTriviaState> weeklyTriviaReducer = combineReducers([
  TypedReducer<WeeklyTriviaState, UpdateWeeklyTriviaDateAction>(_changeDate),
  TypedReducer<WeeklyTriviaState, UpdateRuntimeAction>(_changeRuntime),
  TypedReducer<WeeklyTriviaState, UpdateWeeklyTriviaPassedAction>(
      _changeShowDialog),
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

