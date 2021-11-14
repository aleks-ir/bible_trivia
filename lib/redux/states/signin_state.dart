
import 'package:meta/meta.dart';

@immutable
class SignInState{


  final String password;
  final String email;

  SignInState({required this.password,
      required this.email});


  SignInState copyWith({
    required String? password,
    required String? email,
  }){
    return new SignInState(
        password: password ?? this.password,
        email: email ?? this.email,
    );
  }

  factory SignInState.initial(){
    return new SignInState(
        password: "",
        email: "",);

  }
}