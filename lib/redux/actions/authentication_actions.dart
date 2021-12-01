
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/models/user_firebase.dart';

class AuthSuccessfulAction {
  final UserFirebase user;
  AuthSuccessfulAction({ required this.user});
}

class UpdateAuthErrorAction {
  final String authError;
  UpdateAuthErrorAction(this.authError);
}

class UpdateSignUpErrorAction {
  final String signUpError;
  UpdateSignUpErrorAction(this.signUpError);
}

class UpdateAuthStatusAction{
  final AuthenticationStatus status;
  UpdateAuthStatusAction(this.status);
}