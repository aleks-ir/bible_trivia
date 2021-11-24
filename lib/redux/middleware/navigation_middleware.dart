import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/constants/enums/navigation_tabs.dart';
import 'package:weekly_bible_trivia/constants/route_paths.dart';
import 'package:weekly_bible_trivia/redux/actions/transition_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/services/navigation_service.dart';

import '../../utils/locator.dart';

final NavigationService _navigationService = locator<NavigationService>();

ThunkAction<AppState> updateTabThunk(NavigationTab tab) {
  return (Store<AppState> store) {
    // if(tab == AppTab.home){
    //   store.dispatch(UpdateHomeTitleAction("Home Middleware"));
    // }else if(tab == AppTab.reader){
    //   store.dispatch(UpdateReaderTitleAction("Reader Middleware"));
    // }else if(tab == AppTab.pastTrivia){
    //   store.dispatch(UpdatePastTriviaTitleAction("Trivia Middleware"));
    // }
    //TODO: Middleware realization
    store.dispatch(UpdateNavigationTabAction(tab));
  };
}

ThunkAction<AppState> updateScreenThunk(dynamic action) {
  return (Store<AppState> store) {
    if (action is NavigateToHomeAction) {
      _navigationService.navigate(RoutePaths.toMainScreen);
      return;
    }else if(action is NavigateFromHomeToSignInScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToSignInScreen);
      return;
    } else if(action is NavigateFromHomeToTableResultsScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToTableResultsScreen);
      return;
    }else if(action is NavigateFromHomeToAboutScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToAboutScreen);
      return;
    }else if(action is NavigateFromHomeToEditProfileScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToEditProfileScreen);
      return;
    }else if(action is NavigateFromHomeToMainTriviaScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToMainTriviaScreen);
      return;
    }else if(action is NavigateFromHomeToPastTriviaScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToPastTriviaScreen);
      return;
    }else if(action is NavigateFromHomeToSearchScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToSearchScreen);
      return;
    }else if(action is NavigateFromHomeToSetChapterScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToSetChapterScreen);
      return;
    }else if(action is NavigateFromHomeToSetTranslationScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToSetTranslationScreen);
      return;
    }else if(action is NavigateFromSignInToHomeScreenAction) {
      store.dispatch(ClearErrorsAction());
      _navigationService.navigate(RoutePaths.fromSignInToHomeScreen);
      return;
    }else if(action is NavigateFromSignInToSignUpScreenAction) {
      _navigationService.navigate(RoutePaths.fromSignInToSignUpScreen);
      return;
    }else if(action is NavigateFromSignUpToHomeScreenAction) {
      store.dispatch(ClearErrorsAction());
      _navigationService.navigate(RoutePaths.fromSignUpToHomeScreen);
      return;
    }else if(action is NavigateFromTableResultsToHomeScreenAction) {
      _navigationService.navigate(RoutePaths.fromTableResultsToHomeScreen);
      return;
    }else if(action is NavigateFromAboutToHomeScreenAction) {
      _navigationService.navigate(RoutePaths.fromAboutToHomeScreen);
      return;
    }else if(action is NavigateFromEditProfileToHomeScreenAction) {
      _navigationService.navigate(RoutePaths.fromEditProfileToHomeScreen);
      return;
    }else if(action is NavigateFromMainTriviaToResultScreenAction) {
      _navigationService.navigate(RoutePaths.fromMainTriviaToResultScreen);
      return;
    }else if(action is NavigateFromPastTriviaToResultScreenAction) {
      _navigationService.navigate(RoutePaths.fromPastTriviaToResultScreen);
      return;
    }else if(action is NavigateFromResultToHomeScreenAction) {
      _navigationService.navigate(RoutePaths.fromResultToHomeScreen);
      return;
    }else if(action is NavigateFromSearchToHomeScreenAction) {
      _navigationService.navigate(RoutePaths.fromSearchToHomeScreen);
      return;
    }else if(action is NavigateFromSetChapterToHomeScreenAction) {
      _navigationService.navigate(RoutePaths.fromSetChapterToHomeScreen);
      return;
    }else if(action is NavigateFromSetTranslationToHomeScreenAction) {
      _navigationService.navigate(RoutePaths.fromSetTranslationToHomeScreen);
      return;
    }
    store.dispatch(action);
  };
}
