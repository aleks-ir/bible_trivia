import 'package:flutter/cupertino.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/models/user_firebase.dart';

@immutable
class AuthenticationState {
  final AuthenticationStatus status;
  final UserFirebase user;
  final String authError;

  const AuthenticationState({
    required this.status,
    required this.user,
    required this.authError,
  });

  AuthenticationState copyWith(
      {AuthenticationStatus? status, UserFirebase? user, String? authError}) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
      authError: authError ?? this.authError,
    );
  }

  factory AuthenticationState.initial() {
    return AuthenticationState(
        authError: '',
        status: AuthenticationStatus.noLoaded,
        user: UserFirebase('', '', '', DEFAULT_PHOTO_URL));
  }
}
