import 'package:flutter/cupertino.dart';

@immutable
class AuthorizationState {
  final bool isAuthorized;

  const AuthorizationState({
    required this.isAuthorized,
  });

  AuthorizationState copyWith({bool? isAuthorized}) {
    return AuthorizationState(
      isAuthorized: isAuthorized ?? this.isAuthorized,
    );
  }
}