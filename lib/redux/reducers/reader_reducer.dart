import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/database_actions.dart';
import 'package:weekly_bible_trivia/redux/states/reader_state.dart';

Reducer<ReaderState> readerReducer = combineReducers([
  TypedReducer<ReaderState, UpdateTextReaderAction>(_changeTextReaderAction),
]);


ReaderState _changeTextReaderAction(
    ReaderState prevState, UpdateTextReaderAction action) {
  return prevState.copyWith(
    textReader: action.textReader,
  );
}