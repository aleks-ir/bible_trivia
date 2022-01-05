import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/models/signin_request.dart';
import 'package:weekly_bible_trivia/redux/actions/authentication_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/validation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';
import 'package:weekly_bible_trivia/widgets/error_validation.dart';
import 'package:weekly_bible_trivia/widgets/progress_indicators.dart';
import 'package:weekly_bible_trivia/widgets/snack_bar.dart';
import 'package:weekly_bible_trivia/widgets/text_form_fields.dart';

class SignInContainer extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  late final bool isErrorListener;

  SignInContainer(this.isErrorListener);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          if (isErrorListener && viewModel.authStatus == AuthenticationStatus.error &&
              viewModel.authError.isNotEmpty) {
            Future.delayed(Duration.zero, () async {
              showSnackBar(context, viewModel.authError, color: Color(viewModel.iconColor));
            });
            viewModel.resetAuthError();
          }

          bool isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;

          Widget createButton() => authOutlinedButton(
              createAccount.i18n, viewModel.navigateToRegistration,
              textColor: Color(viewModel.iconColor));

          Widget singInButton() => authMaterialButton(
                  viewModel.authStatus != AuthenticationStatus.loading
                      ? Text(
                          signIn.i18n,
                        )
                      : miniCircularProgressIndicator(), () {
                FocusScope.of(context).unfocus();
                viewModel.signIn(
                    SignInRequest(_emailController.text, _passController.text));
              }, color: Color(viewModel.iconColor));

          Widget emailTextField() => authTextField(
              textColor: Color(viewModel.textColor),
              borderColor: Color(viewModel.textColor),
              focusedBorderColor: Color(viewModel.iconColor),
              icon: Icons.email,
              controller: _emailController,
              onChanged: (value) => viewModel.validateEmail(value));

          Widget passwordTextField() => authTextField(
              textColor: Color(viewModel.textColor),
              borderColor: Color(viewModel.textColor),
              focusedBorderColor: Color(viewModel.iconColor),
              icon: Icons.lock,
              obscure: true,
              controller: _passController,
              onChanged: (value) => viewModel.validatePassword(value));

          Widget emailErrorBox() => Align(
                alignment: Alignment.center,
                child: viewModel.validStatus == ValidationStatus.error &&
                        viewModel.emailError.isNotEmpty
                    ? errorValidation(viewModel.emailError)
                    : const SizedBox(),
              );

          Widget passwordErrorBox() => viewModel.validStatus == ValidationStatus.error &&
                  viewModel.passwordError.isNotEmpty
              ? errorValidation(viewModel.passwordError)
              : const SizedBox();

          Widget emailTitle() => Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    email.i18n,
                    style: TextStyle(
                      color: Color(viewModel.textColor),
                    ),
                  ),
                ),
          );

          Widget passwordTitle() => Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    password.i18n,
                    style: TextStyle(
                      color: Color(viewModel.textColor),
                    ),
                  ),
                ),
          );

          final Column buttonsGroupColumn = Column(
            children: [
              SizedBox(
                width: isPortrait
                    ? double.infinity
                    : MediaQuery.of(context).size.width / 2,
                child: singInButton(),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: isPortrait
                    ? double.infinity
                    : MediaQuery.of(context).size.width / 2,
                child: createButton(),
              ),
            ],
          );

          final Row emailAndPasswordGroupRow = Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    emailTitle(),
                    SizedBox(height: 5),
                    emailTextField(),
                    emailErrorBox(),
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
                    passwordTitle(),
                    SizedBox(height: 5),
                    passwordTextField(),
                    passwordErrorBox(),
                  ],
                ),
                flex: 10,
              ),
            ],
          );

          final Column emailAndPasswordGroupColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              emailTitle(),
              SizedBox(height: 5),
              emailTextField(),
              emailErrorBox(),
              SizedBox(height: 20),
              passwordTitle(),
              SizedBox(height: 5),
              passwordTextField(),
              passwordErrorBox(),
            ],
          );

          return SizedBox.expand(
            child: Container(
              color: Color(viewModel.primaryColor),
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: isPortrait ? 20.0 : 0),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 48.0,
                        child: Image.asset(PIGEON_IMG),
                      ),
                    ),
                    SizedBox(height: isPortrait ? 20.0 : 0),
                    isPortrait
                        ? emailAndPasswordGroupColumn
                        : emailAndPasswordGroupRow,
                    SizedBox(height: isPortrait ? 20 : 20),
                    buttonsGroupColumn,
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
  final String passwordError;
  final String emailError;
  final String authError;

  final Function(String) validateEmail;
  final Function(String) validatePassword;
  final Function(SignInRequest request) signIn;
  final Function() navigateToRegistration;
  final Function() resetAuthError;

  _ViewModel({
    required this.iconColor,
    required this.primaryColor,
    required this.textColor,
    required this.validStatus,
    required this.authStatus,
    required this.passwordError,
    required this.emailError,
    required this.authError,
    required this.signIn,
    required this.navigateToRegistration,
    required this.validateEmail,
    required this.validatePassword,
    required this.resetAuthError,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        iconColor: store.state.themeSettingsState.iconColor,
        primaryColor: store.state.themeSettingsState.primaryColor,
        textColor: store.state.themeSettingsState.textColor,
        validStatus: store.state.signInState.validationStatus,
        authStatus: store.state.authenticationState.status,
        passwordError: store.state.signInState.passwordError,
        emailError: store.state.signInState.emailError,
        authError: store.state.authenticationState.authError,
        validateEmail: (email) =>
            store.dispatch(validateEmailThunk(email, Screen.signin)),
        validatePassword: (password) =>
            store.dispatch(validatePasswordThunk(password, Screen.signin)),
        signIn: (request) => store.dispatch(validateSignInThunk(request)),
        navigateToRegistration: () => store.dispatch(
            updateScreenThunk(NavigateFromSignInToSignUpScreenAction())),
        resetAuthError: () {
          store.dispatch(UpdateAuthStatusAction(AuthenticationStatus.noLoaded));
          store.dispatch(UpdateAuthErrorAction(''));
        });
  }
}
