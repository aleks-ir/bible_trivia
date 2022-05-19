

import 'package:weekly_bible_trivia/global/enums.dart';

class UpdateNavigationTabAction {
  final NavigationTab newTab;
  UpdateNavigationTabAction(this.newTab);
}

class UpdateActiveAnimation {
  final bool isActiveAnimation;
  UpdateActiveAnimation(this.isActiveAnimation);
}


class NavigateToHomeAction {}

class NavigateFromHomeToSignInScreenAction {}

class NavigateFromHomeToTableResultsScreenAction {}

class NavigateFromHomeToAboutScreenAction {}

class NavigateFromHomeToProfileScreenAction {}

class NavigateFromHomeToTriviaScreenAction {}

class NavigateFromHomeToSearchScreenAction {}

class NavigateFromHomeToSelectionScreenAction {}

class NavigateFromSelectionToTranslationScreenAction {}

class NavigateFromSignInToHomeScreenAction {}

class NavigateFromSignInToSignUpScreenAction {}

class NavigateFromSignUpToHomeScreenAction {}

class NavigateFromTableResultsToHomeScreenAction {}

class NavigateFromAboutToHomeScreenAction {}

class NavigateFromProfileToHomeScreenAction {}

class NavigateFromTriviaToResultScreenAction {}

class NavigateFromTriviaToHomeScreenAction {}

class NavigateFromResultToHomeScreenAction {}

class NavigateFromSearchToHomeScreenAction {}

class NavigateFromSelectionToHomeScreenAction {}

class NavigateFromTranslationToSelectionScreenAction {}

class NavigateFromTranslationToHomeScreenAction{}
