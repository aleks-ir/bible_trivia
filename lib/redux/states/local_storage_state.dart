import 'package:flutter/cupertino.dart';

@immutable
class LocalStorageState {
  final String token;

  const LocalStorageState({
    required this.token,
  });

  LocalStorageState copyWith(
      {String? token}) {
    return LocalStorageState(token: token ?? '',
    );
  }

  factory LocalStorageState.initial() {
    return LocalStorageState(token: '');
  }
}
