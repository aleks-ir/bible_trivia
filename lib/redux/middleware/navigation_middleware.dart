import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/route_paths.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/past_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/services/navigation_service.dart';
import 'package:weekly_bible_trivia/utils/locator.dart';


final NavigationService _navigationService = locator<NavigationService>();

ThunkAction<AppState> updateTabThunk(NavigationTab tab) {
  return (Store<AppState> store) {
    store.dispatch(UpdateNavigationTabAction(tab));
  };
}

ThunkAction<AppState> updateScreenThunk(dynamic action) {
  return (Store<AppState> store) {
    if (action is NavigateToHomeAction) {
      _navigationService.navigate(RoutePaths.toHomeScreen);
      return;
    } else if (action is NavigateFromHomeToSignInScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToSignInScreen);
      return;
    } else if (action is NavigateFromHomeToTableResultsScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToTableResultsScreen);
      return;
    } else if (action is NavigateFromHomeToAboutScreenAction) {
      closeMenuBarAndNavigate(store, RoutePaths.fromHomeToAboutScreen);
      return;
    } else if (action is NavigateFromHomeToProfileScreenAction) {
      _navigationService.navigate(RoutePaths.fromHomeToProfileScreen);
      return;
    } else if (action is NavigateFromHomeToTriviaScreenAction) {
      closeMenuBarAndNavigate(store, RoutePaths.fromHomeToTriviaScreen);
      return;
    } else if (action is NavigateFromHomeToSearchScreenAction) {
      closeMenuBarAndNavigate(store, RoutePaths.fromHomeToSearchScreen);
      return;
    } else if (action is NavigateFromHomeToSelectionScreenAction) {
      closeMenuBarAndNavigate(store, RoutePaths.fromHomeToSelectionReaderScreen);
      return;
    } else if (action is NavigateFromSelectionToTranslationScreenAction) {
      _navigationService.navigate(RoutePaths.fromSelectionReaderToTranslationScreen);
      return;
    } else if (action is NavigateFromSignInToHomeScreenAction) {
      _navigationService.goBack();
      return;
    } else if (action is NavigateFromSignInToSignUpScreenAction) {
      _navigationService.navigate(RoutePaths.fromSignInToSignUpScreen);
      return;
    } else if (action is NavigateFromSignUpToHomeScreenAction) {
      _navigationService.goBack();
      _navigationService.goBack();
      return;
    } else if (action is NavigateFromTableResultsToHomeScreenAction) {
      _navigationService.goBack();
      return;
    } else if (action is NavigateFromAboutToHomeScreenAction) {
      _navigationService.goBack();
      return;
    } else if (action is NavigateFromProfileToHomeScreenAction) {
      _navigationService.goBack();
      return;
    } else if (action is NavigateFromTriviaToResultScreenAction) {
      _navigationService.navigateAndReplace(RoutePaths.fromTriviaToResultScreen);
      return;
    }else if (action is NavigateFromTriviaToHomeScreenAction) {
      _navigationService.goBack();
      return;
    } else if (action is NavigateFromResultToHomeScreenAction) {
      store.dispatch(ResetTriviaDialogAction());
      _navigationService.navigateBack(RoutePaths.fromResultToHomeScreen);
      return;
    } else if (action is NavigateFromSearchToHomeScreenAction) {
      _navigationService.goBack();
      return;
    } else if (action is NavigateFromSelectionToHomeScreenAction) {
      _navigationService.goBack();
      return;
    } else if (action is NavigateFromTranslationToSelectionScreenAction) {
      _navigationService.goBack();
      return;
    }else if (action is NavigateFromTranslationToHomeScreenAction) {
      _navigationService
          .navigateBack(RoutePaths.fromTranslationToHomeScreen);
      return;
    }
    store.dispatch(action);
  };
}

void closeMenuBarAndNavigate(Store<AppState> store, String routePath) {
  if(store.state.appBarState.isShowMenuBar){
    store.dispatch(UpdateShowMenuBarAction(false));
    Future.delayed(const Duration(milliseconds: 0), () {
      _navigationService.navigate(routePath);
    });
  }else{
    _navigationService.navigate(routePath);
  }
}