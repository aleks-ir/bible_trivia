import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/models/signup_request.dart';
import 'package:weekly_bible_trivia/redux/middleware/validation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';
import 'package:weekly_bible_trivia/widgets/error_validation.dart';
import 'package:weekly_bible_trivia/widgets/progress_indicators.dart';
import 'package:weekly_bible_trivia/widgets/text_form_fields.dart';

class SignUpContainer extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _retypePassController = TextEditingController();

  SignUpContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          bool isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;

          Widget nameTextField() => authTextField(
              textColor: Color(viewModel.textColor),
              borderColor: Color(viewModel.textColor),
              focusedBorderColor: Color(viewModel.iconColor),
              icon: Icons.person,
              label: name.i18n,
              controller: _nameController,
              onChanged: (value) => viewModel.validateName(value));

          Widget emailTextField() => authTextField(
              textColor: Color(viewModel.textColor),
              borderColor: Color(viewModel.textColor),
              focusedBorderColor: Color(viewModel.iconColor),
              icon: Icons.email,
              label: email.i18n,
              controller: _emailController,
              onChanged: (value) => viewModel.validateEmail(value));

          Widget passwordTextField() => authTextField(
              textColor: Color(viewModel.textColor),
              borderColor: Color(viewModel.textColor),
              focusedBorderColor: Color(viewModel.iconColor),
              icon: Icons.lock,
              obscure: true,
              label: password.i18n,
              autofocus: false,
              controller: _passController,
              onChanged: (value) => viewModel.validatePassword(value));

          Widget verifyTextField() => authTextField(
              textColor: Color(viewModel.textColor),
              borderColor: Color(viewModel.textColor),
              focusedBorderColor: Color(viewModel.iconColor),
              icon: Icons.lock,
              obscure: true,
              label: verify.i18n,
              autofocus: false,
              controller: _retypePassController,
              onChanged: (value) =>
                  viewModel.validatePasswordMatch(_passController.text, value));

          final Column emailAndNameGroupColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              nameTextField(),
              viewModel.validStatus == ValidationStatus.error &&
                      viewModel.nameError.isNotEmpty
                  ? errorValidation(viewModel.nameError)
                  : const SizedBox(),
              SizedBox(height: 20),
              emailTextField(),
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
                    nameTextField(),
                    viewModel.validStatus == ValidationStatus.error &&
                            viewModel.nameError.isNotEmpty
                        ? errorValidation(viewModel.nameError)
                        : const SizedBox(),
                  ],
                ),
                flex: 10,
              ),
              const Expanded(
                child: SizedBox(),
                flex: 1,
              ),
              Expanded(
                child: Column(
                  children: [
                    emailTextField(),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              passwordTextField(),
              viewModel.validStatus == ValidationStatus.error &&
                      viewModel.passwordError.isNotEmpty
                  ? errorValidation(viewModel.passwordError)
                  : const SizedBox(),
              const SizedBox(height: 20),
              verifyTextField(),
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
                    passwordTextField(),
                    viewModel.validStatus == ValidationStatus.error &&
                            viewModel.passwordError.isNotEmpty
                        ? errorValidation(viewModel.passwordError)
                        : const SizedBox(),
                  ],
                ),
                flex: 10,
              ),
              const Expanded(
                child: SizedBox(),
                flex: 1,
              ),
              Expanded(
                child: Column(
                  children: [
                    verifyTextField(),
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


          final createButton = SizedBox(
            width: isPortrait
                ? double.infinity
                : MediaQuery.of(context).size.width / 2,
            child: authMaterialButton(
                viewModel.authStatus != AuthenticationStatus.loading
                    ? Text(
                  create.i18n,
                )
                    : buttonCircularProgressIndicator(), () {
              FocusScope.of(context).unfocus();
              viewModel.signUp(SignUpRequest(
                  _nameController.text,
                  _emailController.text,
                  _passController.text,
                  _retypePassController.text));
            }, color: Color(viewModel.iconColor)),
          );

          return SizedBox.expand(
            child: Container(
              color: Color(viewModel.primaryColor),
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: isPortrait ? 70 : 50),
                    isPortrait ? emailAndNameGroupColumn : emailAndNameGroupRow,
                    SizedBox(height: isPortrait ? 60 : 30),
                    isPortrait
                        ? passwordAndVerifyGroupColumn
                        : passwordAndVerifyGroupRow,
                    SizedBox(height: 30),
                    createButton,
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class _ViewModel {
  final int iconColor;
  final int primaryColor;
  final int textColor;
  final ValidationStatus validStatus;
  final AuthenticationStatus authStatus;
  final String nameError;
  final String passwordError;
  final String emailError;
  final String retypePasswordError;

  final Function(String) validateName;
  final Function(String) validateEmail;
  final Function(String) validatePassword;
  final Function(String, String) validatePasswordMatch;
  final Function(SignUpRequest request) signUp;

  _ViewModel({
    required this.iconColor,
    required this.primaryColor,
    required this.textColor,
    required this.validStatus,
    required this.authStatus,
    required this.nameError,
    required this.passwordError,
    required this.emailError,
    required this.retypePasswordError,
    required this.validateName,
    required this.validateEmail,
    required this.validatePassword,
    required this.validatePasswordMatch,
    required this.signUp,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      iconColor: store.state.themeSettingsState.iconColor,
      primaryColor: store.state.themeSettingsState.primaryColor,
      textColor: store.state.themeSettingsState.textColor,
      validStatus: store.state.signUpState.validationStatus,
      authStatus: store.state.authenticationState.status,
      nameError: store.state.signUpState.nameError,
      passwordError: store.state.signUpState.passwordError,
      emailError: store.state.signUpState.emailError,
      retypePasswordError: store.state.signUpState.retypePasswordError,
      validateName: (name) =>
          store.dispatch(validateNameThunk(name, Screen.signup)),
      validateEmail: (email) =>
          store.dispatch(validateEmailThunk(email, Screen.signup)),
      validatePassword: (password) =>
          store.dispatch(validatePasswordThunk(password, Screen.signup)),
      validatePasswordMatch: (password, retypePassword) => store.dispatch(
          validatePassMatchThunk(password, retypePassword, Screen.signup)),
      signUp: (request) {
        store.dispatch(validateSignUpThunk(request));
      },
    );
  }
}
