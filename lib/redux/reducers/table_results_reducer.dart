import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/table_results_actions.dart';
import 'package:weekly_bible_trivia/redux/states/table_result_state.dart';


Reducer<TableResultsState> tableResultsReducer = combineReducers([
  TypedReducer<TableResultsState, UpdateListRecordsAction>(
      _changeListRecords),
]);

TableResultsState _changeListRecords(
    TableResultsState prevState, UpdateListRecordsAction action) {
  return prevState.copyWith(
    listRecords: action.listRecords,
  );
}

