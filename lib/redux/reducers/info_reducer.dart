import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/info_actions.dart';
import 'package:weekly_bible_trivia/redux/states/info_state.dart';

Reducer<InfoState> infoReducer = combineReducers([
  TypedReducer<InfoState, UpdateInfoTriviaBookAction>(_changeBookName),
  TypedReducer<InfoState, UpdateInfoTriviaChaptersAction>(_changeChapters),
  TypedReducer<InfoState, UpdateInfoTriviaDateAction>(_changeDate),
  TypedReducer<InfoState, UpdateCurrentDateAction>(_changeCurrentDate),
]);


InfoState _changeBookName(
    InfoState prevState, UpdateInfoTriviaBookAction action) {
  return prevState.copyWith(
    nextBookName: action.bookName,
  );
}

InfoState _changeChapters(
    InfoState prevState, UpdateInfoTriviaChaptersAction action) {
  return prevState.copyWith(
    nextChapters: action.chapters,
  );
}

InfoState _changeDate(
    InfoState prevState, UpdateInfoTriviaDateAction action) {
  return prevState.copyWith(
    nextDate: action.date,
  );
}

InfoState _changeCurrentDate(
    InfoState prevState, UpdateCurrentDateAction action) {
  return prevState.copyWith(
    currentDate: action.currentDate,
  );
}
