import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weekly_bible_trivia/redux/actions/authentication_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons/auth_buttun.dart';
import 'package:weekly_bible_trivia/widgets/text_form_fields/auth_text_form_field.dart';

class SignInContainer extends StatelessWidget {
  const SignInContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          bool isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;

          final Column buttonsGroupColumn = Column(
            children: [
              authButton("Log in", () {}),
              SizedBox(height: 10.0),
              authButton("Create account", viewModel.navigateToRegistration,
                  color: Colors.brown),
            ],
          );

          final Row buttonsGroupRow = Row(
            children: [
              Expanded(child: authButton("Log in", () {}), flex: 10),
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
                        autofocus: false),
                    //viewModel.status == LoadingStatus.error ? emailError(viewModel.emailError) : const SizedBox(),
                    SizedBox(height: 20.0),
                    Text("Password"),
                    SizedBox(height: 5.0),
                    authTextField(
                        icon: Icons.lock,
                        obscure: true,
                        label: '',
                        autofocus: false),
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
  final String password;
  final String email;

  final Function(String email, String password) login;
  final Function() navigateToRegistration;

  _ViewModel(
      {required this.password,
      required this.email,
      required this.login,
      required this.navigateToRegistration});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        email: store.state.signInState.email,
        password: store.state.signInState.password,
        login: (email, password) {
          store.dispatch(UpdateAuthorizationAction(true));
          store.dispatch(new NavigateToHomeAction());
          //store.dispatch(new ValidateLoginFields(email, password));
        },
        navigateToRegistration: () =>
            store.dispatch(updateScreenThunk(NavigateToSignUpAction())));
  }
}
