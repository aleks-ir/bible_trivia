import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/home_actions.dart';
import 'package:weekly_bible_trivia/redux/states/home_state.dart';

Reducer<HomeState> homeReducer = combineReducers([
  TypedReducer<HomeState, ChangeShowInfoTriviaAction>(_updateShowedInfoTriviaAction),
]);


HomeState _updateShowedInfoTriviaAction(
    HomeState prevState, ChangeShowInfoTriviaAction action) {
  return prevState.copyWith(
    isShowedInfoTrivia: action.isShowedInfoTrivia,
  );
}