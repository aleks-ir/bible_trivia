import 'package:meta/meta.dart';

@immutable
class SignUpState {
  final String name;
  final String password;
  final String retypePassword;
  final String email;

  SignUpState(
      {required this.name,
      required this.password,
      required this.retypePassword,
      required this.email});

  SignUpState copyWith({
    String? name,
    String? password,
    String? retypePassword,
    String? email,
  }) {
    return new SignUpState(
      name: name ?? this.name,
      password: password ?? this.password,
      retypePassword: retypePassword ?? this.retypePassword,
      email: email ?? this.email,
    );
  }

  factory SignUpState.initial() {
    return new SignUpState(
      password: "",
      email: "",
      retypePassword: "",
      name: "",
    );
  }
}
