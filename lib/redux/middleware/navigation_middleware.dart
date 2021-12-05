import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/route_paths.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
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
      _navigationService.navigate(RoutePaths.toHomeScreen);
      return;
    } else if (action is NavigateBackToHomeAction) {
      _navigationService.navigateBack(RoutePaths.toHomeScreen);
      return;
    } else if (action is NavigateFromHomeToSignInScreenAction) {
      store.dispatch(ClearErrorsAction());
      _navigationService.navigate(RoutePaths.fromHomeToSignInScreen);
      return;
    } else if (action is NavigateFromHomeToTableResultsScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToTableResultsScreen);
      return;
    } else if (action is NavigateFromHomeToAboutScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToAboutScreen);
      return;
    } else if (action is NavigateFromHomeToEditProfileScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToEditProfileScreen);
      return;
    } else if (action is NavigateFromHomeToMainTriviaScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToMainTriviaScreen);
      return;
    } else if (action is NavigateFromHomeToPastTriviaScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToPastTriviaScreen);
      return;
    } else if (action is NavigateFromHomeToSearchScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToSearchScreen);
      return;
    } else if (action is NavigateFromHomeToSetChapterScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToSetChapterScreen);
      return;
    } else if (action is NavigateFromHomeToSetTranslationScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToSetTranslationScreen);
      return;
    } else if (action is NavigateFromSignInToHomeScreenAction) {
      _navigationService.navigateBack(RoutePaths.fromSignInToHomeScreen);
      return;
    } else if (action is NavigateFromSignInToSignUpScreenAction) {
      store.dispatch(ClearErrorsAction());
      _navigationService.navigate(RoutePaths.fromSignInToSignUpScreen);
      return;
    } else if (action is NavigateFromSignUpToHomeScreenAction) {
      _navigationService.navigateBack(RoutePaths.fromSignUpToHomeScreen);
      return;
    } else if (action is NavigateFromTableResultsToHomeScreenAction) {
      _navigationService.navigate(RoutePaths.fromTableResultsToHomeScreen);
      return;
    } else if (action is NavigateFromAboutToHomeScreenAction) {
      _navigationService.navigateBack(RoutePaths.fromAboutToHomeScreen);
      return;
    } else if (action is NavigateFromEditProfileToHomeScreenAction) {
      _navigationService.navigateBack(RoutePaths.fromEditProfileToHomeScreen);
      return;
    } else if (action is NavigateFromMainTriviaToResultScreenAction) {
      _navigationService.navigate(RoutePaths.fromMainTriviaToResultScreen);
      return;
    } else if (action is NavigateFromPastTriviaToResultScreenAction) {
      _navigationService.navigate(RoutePaths.fromPastTriviaToResultScreen);
      return;
    } else if (action is NavigateFromResultToHomeScreenAction) {
      _navigationService.navigateBack(RoutePaths.fromResultToHomeScreen);
      return;
    } else if (action is NavigateFromSearchToHomeScreenAction) {
      _navigationService.navigateBack(RoutePaths.fromSearchToHomeScreen);
      return;
    } else if (action is NavigateFromSetChapterToHomeScreenAction) {
      _navigationService.navigateBack(RoutePaths.fromSetChapterToHomeScreen);
      return;
    } else if (action is NavigateFromSetTranslationToHomeScreenAction) {
      _navigationService
          .navigateBack(RoutePaths.fromSetTranslationToHomeScreen);
      return;
    }
    store.dispatch(action);
  };
}
