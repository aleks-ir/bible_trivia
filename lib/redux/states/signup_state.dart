import 'package:meta/meta.dart';
import 'package:weekly_bible_trivia/models/validation_status.dart';

@immutable
class SignUpState {
  final ValidationStatus validationStatus;
  final String name;
  final String nameError;
  final String password;
  final String passwordError;
  final String retypePassword;
  final String retypePasswordError;
  final String email;
  final String emailError;

  SignUpState({
    required this.validationStatus,
    required this.password,
    required this.passwordError,
    required this.retypePassword,
    required this.retypePasswordError,
    required this.email,
    required this.emailError,
    required this.name,
    required this.nameError,
  });

  SignUpState copyWith(
      {ValidationStatus? validationStatus,
      String? password,
      String? passwordError,
      String? retypePassword,
      String? retypePasswordError,
      String? email,
      String? emailError,
      String? name,
      String? nameError}) {
    return SignUpState(
        password: password ?? this.password,
        email: email ?? this.email,
        validationStatus: validationStatus ?? this.validationStatus,
        passwordError: passwordError ?? this.passwordError,
        retypePasswordError: retypePasswordError ?? this.retypePasswordError,
        retypePassword: retypePassword ?? this.retypePassword,
        emailError: emailError ?? this.emailError,
        name: name ?? this.nameError,
        nameError: nameError ?? this.nameError);
  }

  factory SignUpState.initial() {
    return SignUpState(
      validationStatus: ValidationStatus.success,
      password: '',
      passwordError: '',
      retypePassword: '',
      retypePasswordError: '',
      email: '',
      emailError: '',
      name: '',
      nameError: '',
    );
  }
}
