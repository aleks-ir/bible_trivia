
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/loading_actions.dart';
import 'package:weekly_bible_trivia/redux/states/loading_state.dart';


Reducer<LoadingState> loadingReducer = combineReducers([
  TypedReducer<LoadingState, LoadedAppAction>(
      _changeLoadingApp),
  TypedReducer<LoadingState, UpdateLoadingAppDataFromApiAction>(
      _changeLoadingDataFromApi),
  TypedReducer<LoadingState, UpdateLoadingAppDataFromFirebaseAction>(
      _changeLoadingDataFromFirebase),
  TypedReducer<LoadingState, UpdateSearchingAction>(
      _changeSearching),
]);

LoadingState _changeLoadingApp(
    LoadingState prevState, LoadedAppAction action) {
  return prevState.copyWith(
    isLoadingApp: false,
  );
}

LoadingState _changeLoadingDataFromApi(
    LoadingState prevState, UpdateLoadingAppDataFromApiAction action) {
  return prevState.copyWith(
    isLoadingDataFromApi: action.loadingDataFromApi,
  );
}

LoadingState _changeLoadingDataFromFirebase(
    LoadingState prevState, UpdateLoadingAppDataFromFirebaseAction action) {
  return prevState.copyWith(
    isLoadingDataFromFirebase: action.loadingDataFromFirebase,
  );
}

LoadingState _changeSearching(
    LoadingState prevState, UpdateSearchingAction action) {
  return prevState.copyWith(
    isSearching: action.searching,
  );
}
