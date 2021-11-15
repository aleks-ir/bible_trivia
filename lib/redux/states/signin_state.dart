import 'package:meta/meta.dart';
import 'package:weekly_bible_trivia/models/loading_status.dart';

@immutable
class SignInState {
  final LoadingStatus loadingStatus;
  final String password;
  final String passwordError;
  final String email;
  final String emailError;

  SignInState(
      {required this.loadingStatus,
      required this.password,
      required this.passwordError,
      required this.email,
      required this.emailError});

  SignInState copyWith({
    LoadingStatus? loadingStatus,
    String? password,
    String? passwordError,
    String? email,
    String? emailError
  }) {
    return SignInState(
      password: password ?? this.password,
      email: email ?? this.email,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      passwordError: passwordError ?? this.passwordError,
      emailError: emailError ?? this.emailError,
    );
  }

  factory SignInState.initial() {
    return SignInState(
      loadingStatus: LoadingStatus.success,
      password: "",
      passwordError: "",
      email: "",
      emailError: "",
    );
  }
}
