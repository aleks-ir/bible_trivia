import 'package:weekly_bible_trivia/redux/states/app_tab.dart';

class UpdateTabAction {
  final AppTab newTab;
  UpdateTabAction(this.newTab);
}

class NavigateToHomeAction {}

class NavigateToSignInAction {}

class NavigateToSignOutAction {}

class NavigateToSignUpAction {}

class NavigateBackToHomeAction {}