import 'package:meta/meta.dart';
import 'package:weekly_bible_trivia/global/enums.dart';

@immutable
class SignUpState {
  final ValidationStatus validationStatus;
  final String nameError;
  final String passwordError;
  final String retypePasswordError;
  final String emailError;

  SignUpState({
    required this.validationStatus,
    required this.passwordError,
    required this.retypePasswordError,
    required this.emailError,
    required this.nameError,
  });

  SignUpState copyWith(
      {ValidationStatus? validationStatus,
      String? passwordError,
      String? retypePasswordError,
      String? emailError,
      String? nameError}) {
    return SignUpState(
        validationStatus: validationStatus ?? this.validationStatus,
        passwordError: passwordError ?? this.passwordError,
        retypePasswordError: retypePasswordError ?? this.retypePasswordError,
        emailError: emailError ?? this.emailError,
        nameError: nameError ?? this.nameError);
  }

  factory SignUpState.initial() {
    return SignUpState(
      validationStatus: ValidationStatus.success,
      passwordError: '',
      retypePasswordError: '',
      emailError: '',
      nameError: '',
    );
  }
}
