import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weekly_bible_trivia/constants/strings.dart';
import 'package:weekly_bible_trivia/redux/actions/local_storage_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';


ThunkAction<AppState> checkTokenThunk() {
  return (Store<AppState> store) async {
     SharedPreferences preferences = await SharedPreferences.getInstance();;

      var token = preferences.getString(TOKEN);
      if(token != null && token.isNotEmpty){
        store.dispatch(TokenAction(token));
      }else{
        store.dispatch(TokenAction(''));
    }
  };
}

ThunkAction<AppState> saveTokenThunk(String token) {
  return (Store<AppState> store) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();;

    preferences.setString(TOKEN, token);
    store.dispatch(TokenAction(token));
  };
}