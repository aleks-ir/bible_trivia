import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/redux/actions/home_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/past_trivia_action.dart';
import 'package:weekly_bible_trivia/redux/actions/reader_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/transition_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/redux/states/app_tab.dart';

ThunkAction<AppState> updateTabThunk(AppTab tab) {
  return (Store<AppState> store) async {
    if(tab == AppTab.home){
      store.dispatch(UpdateHomeTitleAction("Home Middleware"));
    }else if(tab == AppTab.reader){
      store.dispatch(UpdateReaderTitleAction("Reader Middleware"));
    }else if(tab == AppTab.pastTrivia){
      store.dispatch(UpdatePastTriviaTitleAction("Trivia Middleware"));
    }
    //TODO: Middleware realization
    print("Middleware");
    store.dispatch(UpdateTabAction(tab));
  };
}



