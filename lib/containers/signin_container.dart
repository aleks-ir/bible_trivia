import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weekly_bible_trivia/models/loading_status.dart';
import 'package:weekly_bible_trivia/models/screens.dart';
import 'package:weekly_bible_trivia/models/signin_request.dart';
import 'package:weekly_bible_trivia/redux/actions/authentication_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/validation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons/auth_buttun.dart';
import 'package:weekly_bible_trivia/widgets/error_validation.dart';
import 'package:weekly_bible_trivia/widgets/text_form_fields/auth_text_form_field.dart';

class SignInContainer extends StatefulWidget {
  @override
  _SignInContainerState createState() => _SignInContainerState();
}

class _SignInContainerState extends State<SignInContainer>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          bool isPortrait =
              MediaQuery
                  .of(context)
                  .orientation == Orientation.portrait;


          final Column buttonsGroupColumn = Column(
            children: [
              authButton("Log in", () {
                viewModel.signIn(SignInRequest(_emailController.text, _passController.text));
              }),
              SizedBox(height: 10.0),
              authButton("Create account", viewModel.navigateToRegistration,
                  color: Colors.brown),
            ],
          );

          final Row buttonsGroupRow = Row(
            children: [
              Expanded(
                  child: authButton("Log in", () {
                    viewModel.signIn(SignInRequest(_emailController.text, _passController.text));
                  }),
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
                      child: viewModel.status == LoadingStatus.error &&
                          viewModel.emailError.isNotEmpty
                          ? errorValidation(viewModel.emailError)
                          : const SizedBox(),
                    ),
                    SizedBox(height: 20.0),
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
                      child: viewModel.status == LoadingStatus.error &&
                          viewModel.passwordError.isNotEmpty
                          ? errorValidation(viewModel.passwordError)
                          : const SizedBox(),
                    ),
                    SizedBox(height: 30.0),
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
  final LoadingStatus status;
  final String password;
  final String passwordError;
  final String email;
  final String emailError;

  final Function(String) validateEmail;
  final Function(String) validatePassword;
  final Function(SignInRequest request) signIn;
  final Function() navigateToRegistration;

  _ViewModel({
    required this.status,
    required this.password,
    required this.passwordError,
    required this.email,
    required this.emailError,
    required this.signIn,
    required this.navigateToRegistration,
    required this.validateEmail,
    required this.validatePassword,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        status: store.state.signInState.loadingStatus,
        password: store.state.signInState.password,
        passwordError: store.state.signInState.passwordError,
        email: store.state.signInState.email,
        emailError: store.state.signInState.emailError,
        validateEmail: (email) =>
            store.dispatch(validateEmailThunk(email, Screens.SIGNIN)),
        validatePassword: (password) =>
            store
                .dispatch(validatePasswordThunk(password, Screens.SIGNIN)),
        signIn: (request) {
          store.dispatch(validateSignInThunk(request));
          //store.dispatch(new NavigateToHomeAction());
          //store.dispatch(new ValidateLoginFields(email, password));
        },
        navigateToRegistration: () =>
            store.dispatch(updateScreenThunk(NavigateToSignUpAction())));
  }
}
