import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weekly_bible_trivia/models/authentication_status.dart';
import 'package:weekly_bible_trivia/models/validation_status.dart';
import 'package:weekly_bible_trivia/models/screens.dart';
import 'package:weekly_bible_trivia/models/signup_request.dart';
import 'package:weekly_bible_trivia/redux/actions/authentication_action.dart';
import 'package:weekly_bible_trivia/redux/middleware/validation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/redux/states/authentication_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons/auth_buttun.dart';
import 'package:weekly_bible_trivia/widgets/error_validation.dart';
import 'package:weekly_bible_trivia/widgets/snack_bar.dart';
import 'package:weekly_bible_trivia/widgets/text_form_fields/auth_text_form_field.dart';

class SignUpContainer extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _retypePassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          bool isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;

          final Column emailAndNameGroupColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              authTextField(
                  icon: Icons.person,
                  obscure: false,
                  label: 'Name',
                  autofocus: false,
                  controller: _nameController,
                  onChanged: (value) => viewModel.validateName(value)),
              viewModel.validStatus == ValidationStatus.error &&
                      viewModel.nameError.isNotEmpty
                  ? errorValidation(viewModel.nameError)
                  : const SizedBox(),
              SizedBox(height: 20),
              authTextField(
                  icon: Icons.email,
                  obscure: false,
                  label: 'Email',
                  autofocus: false,
                  controller: _emailController,
                  onChanged: (value) => viewModel.validateEmail(value)),
              viewModel.validStatus == ValidationStatus.error &&
                      viewModel.emailError.isNotEmpty
                  ? errorValidation(viewModel.emailError)
                  : const SizedBox(),
            ],
          );

          final Row emailAndNameGroupRow = Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    authTextField(
                        icon: Icons.person,
                        obscure: false,
                        label: 'Name',
                        autofocus: false,
                        controller: _nameController,
                        onChanged: (value) => viewModel.validateName(value)),
                    viewModel.validStatus == ValidationStatus.error &&
                            viewModel.nameError.isNotEmpty
                        ? errorValidation(viewModel.nameError)
                        : const SizedBox(),
                  ],
                ),
                flex: 10,
              ),
              Expanded(
                child: SizedBox(),
                flex: 1,
              ),
              Expanded(
                child: Column(
                  children: [
                    authTextField(
                        icon: Icons.email,
                        obscure: false,
                        label: 'Email',
                        autofocus: false,
                        controller: _emailController,
                        onChanged: (value) => viewModel.validateEmail(value)),
                    viewModel.validStatus == ValidationStatus.error &&
                            viewModel.emailError.isNotEmpty
                        ? errorValidation(viewModel.emailError)
                        : const SizedBox(),
                  ],
                ),
                flex: 10,
              ),
            ],
          );

          final Column passwordAndVerifyGroupColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              authTextField(
                  icon: Icons.lock,
                  obscure: true,
                  label: 'Password',
                  autofocus: false,
                  controller: _passController,
                  onChanged: (value) => viewModel.validatePassword(value)),
              viewModel.validStatus == ValidationStatus.error &&
                      viewModel.passwordError.isNotEmpty
                  ? errorValidation(viewModel.passwordError)
                  : const SizedBox(),
              SizedBox(height: 20),
              authTextField(
                  icon: Icons.lock,
                  obscure: true,
                  label: 'Verify',
                  autofocus: false,
                  controller: _retypePassController,
                  onChanged: (value) => viewModel.validatePasswordMatch(
                      _passController.text, value)),
              viewModel.validStatus == ValidationStatus.error &&
                      viewModel.retypePasswordError.isNotEmpty
                  ? errorValidation(viewModel.retypePasswordError)
                  : const SizedBox(),
            ],
          );

          final Row passwordAndVerifyGroupRow = Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    authTextField(
                        icon: Icons.lock,
                        obscure: true,
                        label: 'Password',
                        autofocus: false,
                        controller: _passController,
                        onChanged: (value) =>
                            viewModel.validatePassword(value)),
                    viewModel.validStatus == ValidationStatus.error &&
                            viewModel.passwordError.isNotEmpty
                        ? errorValidation(viewModel.passwordError)
                        : const SizedBox(),
                  ],
                ),
                flex: 10,
              ),
              Expanded(
                child: SizedBox(),
                flex: 1,
              ),
              Expanded(
                child: Column(
                  children: [
                    authTextField(
                        icon: Icons.lock,
                        obscure: true,
                        label: 'Verify',
                        autofocus: false,
                        controller: _retypePassController,
                        onChanged: (value) => viewModel.validatePasswordMatch(
                            _passController.text, value)),
                    viewModel.validStatus == ValidationStatus.error &&
                            viewModel.retypePasswordError.isNotEmpty
                        ? errorValidation(viewModel.retypePasswordError)
                        : const SizedBox(),
                  ],
                ),
                flex: 10,
              ),
            ],
          );

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: isPortrait ? 70 : 20),
                isPortrait ? emailAndNameGroupColumn : emailAndNameGroupRow,
                SizedBox(height: isPortrait ? 60 : 30),
                isPortrait
                    ? passwordAndVerifyGroupColumn
                    : passwordAndVerifyGroupRow,
                SizedBox(height: 30),
                viewModel.authStatus != AuthenticationStatus.loading ? authButton("Create", () {
                  FocusScope.of(context).unfocus();
                  viewModel.signUp(SignUpRequest(
                      _nameController.text,
                      _emailController.text,
                      _passController.text,
                      _retypePassController.text));
                }, color: Colors.brown) : CircularProgressIndicator(),
              ],
            ),
          );
        });
  }
}

class _ViewModel {
  final ValidationStatus validStatus;
  final AuthenticationStatus authStatus;
  final String name;
  final String nameError;
  final String password;
  final String passwordError;
  final String email;
  final String emailError;
  final String retypePassword;
  final String retypePasswordError;

  final Function(String) validateName;
  final Function(String) validateEmail;
  final Function(String) validatePassword;
  final Function(String, String) validatePasswordMatch;
  final Function(SignUpRequest request) signUp;

  _ViewModel({
    required this.validStatus,
    required this.authStatus,
    required this.name,
    required this.nameError,
    required this.password,
    required this.passwordError,
    required this.email,
    required this.emailError,
    required this.retypePassword,
    required this.retypePasswordError,
    required this.validateName,
    required this.validateEmail,
    required this.validatePassword,
    required this.validatePasswordMatch,
    required this.signUp,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      validStatus: store.state.signUpState.validationStatus,
      authStatus: store.state.authenticationState.status,
      name: store.state.signUpState.name,
      nameError: store.state.signUpState.nameError,
      password: store.state.signUpState.password,
      passwordError: store.state.signUpState.passwordError,
      email: store.state.signUpState.email,
      emailError: store.state.signUpState.emailError,
      retypePassword: store.state.signUpState.retypePassword,
      retypePasswordError: store.state.signUpState.retypePasswordError,
      validateName: (name) =>
          store.dispatch(validateNameThunk(name, Screens.SIGNUP)),
      validateEmail: (email) =>
          store.dispatch(validateEmailThunk(email, Screens.SIGNUP)),
      validatePassword: (password) =>
          store.dispatch(validatePasswordThunk(password, Screens.SIGNUP)),
      validatePasswordMatch: (password, retypePassword) => store.dispatch(
          validatePassMatchThunk(password, retypePassword, Screens.SIGNUP)),
      signUp: (request) {
        store.dispatch(validateSignUpThunk(request));
      },
    );
  }
}
