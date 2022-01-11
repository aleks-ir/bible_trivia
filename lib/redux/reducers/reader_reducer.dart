import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/reader_actions.dart';
import 'package:weekly_bible_trivia/redux/states/reader_state.dart';

Reducer<ReaderState> readerReducer = combineReducers([
  TypedReducer<ReaderState, UpdateTextReaderAction>(_changeTextReader),
]);


ReaderState _changeTextReader(
    ReaderState prevState, UpdateTextReaderAction action) {
  return prevState.copyWith(
    textReader: action.textReader,
  );
}