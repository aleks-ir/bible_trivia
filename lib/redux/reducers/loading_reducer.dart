
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/load_app_action.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}
