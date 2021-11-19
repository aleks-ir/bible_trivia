import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weekly_bible_trivia/models/authentication_status.dart';
import 'package:weekly_bible_trivia/models/validation_status.dart';
import 'package:weekly_bible_trivia/models/screens.dart';
import 'package:weekly_bible_trivia/models/signin_request.dart';
import 'package:weekly_bible_trivia/redux/actions/authentication_action.dart';
import 'package:weekly_bible_trivia/redux/actions/transition_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/validation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons/auth_buttun.dart';
import 'package:weekly_bible_trivia/widgets/error_validation.dart';
import 'package:weekly_bible_trivia/widgets/snack_bar.dart';
import 'package:weekly_bible_trivia/widgets/text_form_fields/auth_text_form_field.dart';

class SignInContainer extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          if (viewModel.authStatus == AuthenticationStatus.error && viewModel.authError.isNotEmpty) {
            Future.delayed(Duration.zero, () async {
              showSnackBar(context, viewModel.authError);
            });
            viewModel.resetAuthError();
          }

          bool isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;

          final Column buttonsGroupColumn = Column(
            children: [
              viewModel.authStatus != AuthenticationStatus.loading ? authButton("Log in", () {
                FocusScope.of(context).unfocus();
                viewModel.signIn(SignInRequest(
                    _emailController.text, _passController.text));
              }) : CircularProgressIndicator(),
              SizedBox(height: 10.0),
              authButton("Create account", viewModel.navigateToRegistration,
                  color: Colors.brown),
            ],
          );

          final Row buttonsGroupRow = Row(
            children: [
              Expanded(
                  child: viewModel.authStatus != AuthenticationStatus.loading ? authButton("Log in", () {
                    FocusScope.of(context).unfocus();
                    viewModel.signIn(SignInRequest(
                        _emailController.text, _passController.text));
                  }) : CircularProgressIndicator(),
                  flex: 10),
              Expanded(
                child: SizedBox(),
                flex: 1,
              ),
              Expanded(
                child: authButton(
                    "Create account", viewModel.navigateToRegistration,
                    color: Colors.brown),
                flex: 10,
              ),
            ],
          );

          return Stack(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 33.0),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: isPortrait ? 48.0 : 0,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: isPortrait ? 100.0 : 10),
                    Text("Email"),
                    SizedBox(height: 5.0),
                    authTextField(
                        icon: Icons.email,
                        obscure: false,
                        label: '',
                        autofocus: false,
                        controller: _emailController,
                        onChanged: (value) => viewModel.validateEmail(value)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: viewModel.validStatus == ValidationStatus.error &&
                              viewModel.emailError.isNotEmpty
                          ? errorValidation(viewModel.emailError)
                          : const SizedBox(),
                    ),
                    SizedBox(height: isPortrait ? 20 : 10),
                    Text("Password"),
                    SizedBox(height: 5.0),
                    authTextField(
                        icon: Icons.lock,
                        obscure: true,
                        label: '',
                        autofocus: false,
                        controller: _passController,
                        onChanged: (value) =>
                            viewModel.validatePassword(value)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: viewModel.validStatus == ValidationStatus.error &&
                              viewModel.passwordError.isNotEmpty
                          ? errorValidation(viewModel.passwordError)
                          : const SizedBox(),
                    ),
                    SizedBox(height: isPortrait ? 30 : 15),
                    isPortrait ? buttonsGroupColumn : buttonsGroupRow,
                  ],
                ),
              ),
            ],
          );
        });
  }
}

class _ViewModel {
  final ValidationStatus validStatus;
  final AuthenticationStatus authStatus;
  final String password;
  final String passwordError;
  final String email;
  final String emailError;
  final String authError;

  final Function(String) validateEmail;
  final Function(String) validatePassword;
  final Function(SignInRequest request) signIn;
  final Function() navigateToRegistration;
  final Function() resetAuthError;

  _ViewModel({
    required this.validStatus,
    required this.authStatus,
    required this.password,
    required this.passwordError,
    required this.email,
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
        validStatus: store.state.signInState.validationStatus,
        authStatus: store.state.authenticationState.status,
        password: store.state.signInState.password,
        passwordError: store.state.signInState.passwordError,
        email: store.state.signInState.email,
        emailError: store.state.signInState.emailError,
        authError: store.state.authenticationState.authError,
        validateEmail: (email) =>
            store.dispatch(validateEmailThunk(email, Screens.SIGNIN)),
        validatePassword: (password) =>
            store.dispatch(validatePasswordThunk(password, Screens.SIGNIN)),
        signIn: (request) => store.dispatch(validateSignInThunk(request)),
        navigateToRegistration: () =>
            store.dispatch(updateScreenThunk(NavigateToSignUpAction())),
        resetAuthError: () {
          store.dispatch(ChangeAuthStatusAction(AuthenticationStatus.noLoaded));
          store.dispatch(AuthErrorAction(''));
        });
  }
}
