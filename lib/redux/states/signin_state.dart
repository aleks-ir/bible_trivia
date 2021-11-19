import 'package:meta/meta.dart';
import 'package:weekly_bible_trivia/models/validation_status.dart';

@immutable
class SignInState {
  final ValidationStatus validationStatus;
  final String password;
  final String passwordError;
  final String email;
  final String emailError;

  SignInState(
      {required this.validationStatus,
      required this.password,
      required this.passwordError,
      required this.email,
      required this.emailError});

  SignInState copyWith({
    ValidationStatus? validationStatus,
    String? password,
    String? passwordError,
    String? email,
    String? emailError
  }) {
    return SignInState(
      password: password ?? this.password,
      email: email ?? this.email,
      validationStatus: validationStatus ?? this.validationStatus,
      passwordError: passwordError ?? this.passwordError,
      emailError: emailError ?? this.emailError,
    );
  }

  factory SignInState.initial() {
    return SignInState(
      validationStatus: ValidationStatus.success,
      password: "",
      passwordError: "",
      email: "",
      emailError: "",
    );
  }
}
