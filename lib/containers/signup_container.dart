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


          final Column emailAndNameGroupColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AuthTextField(
                onChanged: (value) => viewModel.validateName(value),
                controller: _nameController,
                icon: Icons.person,
                label: name.i18n,
                error: viewModel.validStatus == ValidationStatus.error &&
                    viewModel.nameError.isNotEmpty ? viewModel.nameError : '',
                textColor: Color(viewModel.textColor),
                borderColor: Color(viewModel.textColor),
                focusedBorderColor: Color(viewModel.iconColor),
              ),
              const SizedBox(height: 10,),
              AuthTextField(
                onChanged: (value) => viewModel.validateEmail(value),
                controller: _emailController,
                icon: Icons.email,
                label: email.i18n,
                error: viewModel.validStatus == ValidationStatus.error &&
                    viewModel.emailError.isNotEmpty ? viewModel.emailError : '',
                textColor: Color(viewModel.textColor),
                borderColor: Color(viewModel.textColor),
                focusedBorderColor: Color(viewModel.iconColor),
              ),
            ],
          );

          final Row emailAndNameGroupRow = Row(
            children: [
              Expanded(
                child: AuthTextField(
                  onChanged: (value) => viewModel.validateName(value),
                  controller: _nameController,
                  icon: Icons.person,
                  label: name.i18n,
                  error: viewModel.validStatus == ValidationStatus.error &&
                      viewModel.nameError.isNotEmpty ? viewModel.nameError : '',
                  textColor: Color(viewModel.textColor),
                  borderColor: Color(viewModel.textColor),
                  focusedBorderColor: Color(viewModel.iconColor),
                ),
                flex: 10,
              ),
              const Expanded(
                child: SizedBox(),
                flex: 2,
              ),
              Expanded(
                child: AuthTextField(
                  onChanged: (value) => viewModel.validateEmail(value),
                  controller: _emailController,
                  icon: Icons.email,
                  label: email.i18n,
                  error: viewModel.validStatus == ValidationStatus.error &&
                      viewModel.emailError.isNotEmpty ? viewModel.emailError : '',
                  textColor: Color(viewModel.textColor),
                  borderColor: Color(viewModel.textColor),
                  focusedBorderColor: Color(viewModel.iconColor),
                ),
                flex: 10,
              ),
            ],
          );

          final Column passwordAndVerifyGroupColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AuthTextField(
                onChanged: (value) => viewModel.validatePassword(value),
                controller: _passController,
                icon: Icons.lock,
                label: password.i18n,
                error: viewModel.validStatus == ValidationStatus.error &&
                    viewModel.passwordError.isNotEmpty ? viewModel.passwordError : '',
                obscure: true,
                textColor: Color(viewModel.textColor),
                borderColor: Color(viewModel.textColor),
                focusedBorderColor: Color(viewModel.iconColor),
              ),
              const SizedBox(height: 10,),
              AuthTextField(
                onChanged: (value) =>
                    viewModel.validatePasswordMatch(_passController.text, value),
                controller: _retypePassController,
                icon: Icons.lock,
                label: verify.i18n,
                error: viewModel.validStatus == ValidationStatus.error &&
                    viewModel.retypePasswordError.isNotEmpty ? viewModel.retypePasswordError : '',
                obscure: true,
                textColor: Color(viewModel.textColor),
                borderColor: Color(viewModel.textColor),
                focusedBorderColor: Color(viewModel.iconColor),
              ),
            ],
          );

          final Row passwordAndVerifyGroupRow = Row(
            children: [
              Expanded(
                child:  AuthTextField(
                  onChanged: (value) => viewModel.validatePassword(value),
                  controller: _passController,
                  icon: Icons.lock,
                  label: password.i18n,
                  error: viewModel.validStatus == ValidationStatus.error &&
                      viewModel.passwordError.isNotEmpty ? viewModel.passwordError : '',
                  obscure: true,
                  textColor: Color(viewModel.textColor),
                  borderColor: Color(viewModel.textColor),
                  focusedBorderColor: Color(viewModel.iconColor),
                ),
                flex: 10,
              ),
              const Expanded(
                child: SizedBox(),
                flex: 2,
              ),
              Expanded(
                child:  AuthTextField(
                  onChanged: (value) =>
                      viewModel.validatePasswordMatch(_passController.text, value),
                  controller: _retypePassController,
                  icon: Icons.lock,
                  label: verify.i18n,
                  error: viewModel.validStatus == ValidationStatus.error &&
                      viewModel.passwordError.isNotEmpty ? viewModel.passwordError : '',
                  obscure: true,
                  textColor: Color(viewModel.textColor),
                  borderColor: Color(viewModel.textColor),
                  focusedBorderColor: Color(viewModel.iconColor),
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
                    : circularButtonProgressIndicator(), () {
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: isPortrait ? 40 : 20),
                      isPortrait ? emailAndNameGroupColumn : emailAndNameGroupRow,
                      SizedBox(height: isPortrait ? 50 : 20),
                      isPortrait
                          ? passwordAndVerifyGroupColumn
                          : passwordAndVerifyGroupRow,
                      const SizedBox(height: 40),
                      createButton,
                      const SizedBox(height: 40),
                    ],
                  ),
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
