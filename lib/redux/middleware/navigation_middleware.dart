import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/constants/route_paths.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/home_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/past_trivia_action.dart';
import 'package:weekly_bible_trivia/redux/actions/reader_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/transition_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/redux/states/app_tab.dart';
import 'package:weekly_bible_trivia/services/navigation_service.dart';

import '../../utils/locator.dart';

final NavigationService _navigationService = locator<NavigationService>();

ThunkAction<AppState> updateTabThunk(AppTab tab) {
  return (Store<AppState> store) {
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


ThunkAction<AppState> updateScreenThunk(dynamic action) {
  return (Store<AppState> store) {
    if (action is NavigateToHomeAction) {
      _navigationService.navigateTo(RoutePaths.HomeScreen);
      return;
    }else if(action is NavigateToSignInAction) {
      store.dispatch(ClearErrorsAction());
      _navigationService.navigateTo(RoutePaths.SignInScreen);
      return;
    }else if(action is NavigateToSignUpAction) {
      store.dispatch(ClearErrorsAction());
      _navigationService.navigateTo(RoutePaths.SignUpScreen);
      return;
    }
    store.dispatch(action);
  };
}
