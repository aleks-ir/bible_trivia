import 'package:flutter/cupertino.dart';

@immutable
class AuthenticationState {
  final bool isAuthorized;

  const AuthenticationState({
    required this.isAuthorized,
  });

  AuthenticationState copyWith({bool? isAuthorized}) {
    return AuthenticationState(
      isAuthorized: isAuthorized ?? this.isAuthorized,
    );
  }
}