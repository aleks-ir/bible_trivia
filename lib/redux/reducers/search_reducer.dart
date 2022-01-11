import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/search_actions.dart';
import 'package:weekly_bible_trivia/redux/states/search_state.dart';

Reducer<SearchState> searchReducer = combineReducers([
  TypedReducer<SearchState, UpdateSearchResultAction>(_changeSearchResult),
  TypedReducer<SearchState, UpdateKeywordAction>(_changeKeyword),
  TypedReducer<SearchState, UpdateSearchVerseAction>(_changeVerse),
  TypedReducer<SearchState, ClearSearchAction>(_clearSearchAction)
]);


SearchState _changeSearchResult(
    SearchState prevState, UpdateSearchResultAction action) {
  return prevState.copyWith(
    searchResult: action.searchResult,
  );
}

SearchState _changeKeyword(
    SearchState prevState, UpdateKeywordAction action) {
  return prevState.copyWith(
    keyword: action.keyword,
  );
}

SearchState _changeVerse(
    SearchState prevState, UpdateSearchVerseAction action) {
  return prevState.copyWith(
    verse: action.verse,
  );
}

SearchState _clearSearchAction(SearchState state, ClearSearchAction action) =>
    state.copyWith(searchResult: [], keyword: '', verse: 0);