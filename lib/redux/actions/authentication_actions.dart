import 'package:weekly_bible_trivia/models/loading_status.dart';
import 'package:weekly_bible_trivia/models/screens.dart';
import 'package:weekly_bible_trivia/models/signin_request.dart';
import 'package:weekly_bible_trivia/models/signup_request.dart';

class UpdateAuthorizationAction {
  final bool isAuthorized;
  UpdateAuthorizationAction(this.isAuthorized);
}

class NavigateToHomeAction {}

class NavigateToSignInAction {}

class NavigateToSignOutAction {}

class NavigateToSignUpAction {}

class NavigateBackToHomeAction {}

class SignInAction{
  final SignInRequest request;
  SignInAction(this.request);
}

class SignUpAction{
  final SignUpRequest request;
  SignUpAction(this.request);
}

class NameErrorAction{
  final String message;
  final Screens screen;
  NameErrorAction(this.message, this.screen);
}

class EmailErrorAction{
  final String message;
  final Screens screen;
  EmailErrorAction(this.message, this.screen);
}

class PasswordErrorAction{
  final String message;
  final Screens screen;
  PasswordErrorAction(this.message, this.screen);
}

class RetypePasswordErrorAction{
  final String message;
  final Screens screen;
  RetypePasswordErrorAction(this.message, this.screen);
}


class ChangeLoadingStatusAction{
  final LoadingStatus status;
  ChangeLoadingStatusAction(this.status);
}

class ClearErrorsAction{}