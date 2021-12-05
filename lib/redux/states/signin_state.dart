import 'package:meta/meta.dart';
import 'package:weekly_bible_trivia/global/enums.dart';

@immutable
class SignInState {
  final ValidationStatus validationStatus;
  final String passwordError;
  final String emailError;

  SignInState(
      {required this.validationStatus,
      required this.passwordError,
      required this.emailError});

  SignInState copyWith({
    ValidationStatus? validationStatus,
    String? passwordError,
    String? emailError
  }) {
    return SignInState(
      validationStatus: validationStatus ?? this.validationStatus,
      passwordError: passwordError ?? this.passwordError,
      emailError: emailError ?? this.emailError,
    );
  }

  factory SignInState.initial() {
    return SignInState(
      validationStatus: ValidationStatus.success,
      passwordError: "",
      emailError: "",
    );
  }
}
