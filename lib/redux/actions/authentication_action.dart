import 'package:weekly_bible_trivia/models/authentication_status.dart';
import 'package:weekly_bible_trivia/models/user_firebase.dart';

class AuthSuccessfulAction {
  final UserFirebase user;
  AuthSuccessfulAction({ required this.user});
}

class AuthErrorAction {
  final String authError;
  AuthErrorAction(this.authError);
}

class SignUpErrorAction {
  final String signUpError;
  SignUpErrorAction(this.signUpError);
}

class ChangeAuthStatusAction{
  final AuthenticationStatus status;
  ChangeAuthStatusAction(this.status);
}