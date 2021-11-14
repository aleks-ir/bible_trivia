import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weekly_bible_trivia/redux/actions/authentication_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons/auth_buttun.dart';
import 'package:weekly_bible_trivia/widgets/buttons/log_in_button.dart';
import 'package:weekly_bible_trivia/widgets/text_form_fields/auth_text_form_field.dart';

class SignUpContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          bool isPortrait =
              MediaQuery
                  .of(context)
                  .orientation == Orientation.portrait;

          final Column emailAndNameGroupColumn = Column(
            children: [
              authTextField(
                  icon: Icons.person,
                  obscure: false,
                  label: 'Name',
                  autofocus: false),
              SizedBox(height: 10.0),
              authTextField(
                  icon: Icons.email,
                  obscure: false,
                  label: 'Email',
                  autofocus: false),
            ],
          );

          final Row emailAndNameGroupRow = Row(children: [
            Expanded(
              child: authTextField(
                  icon: Icons.person,
                  obscure: false,
                  label: 'Name',
                  autofocus: false), flex: 10,),
            Expanded(
              child: SizedBox(),
              flex: 1,
            ),
            Expanded(
              child: authTextField(
                  icon: Icons.email,
                  obscure: false,
                  label: 'Email',
                  autofocus: false),
              flex: 10,
            ),
          ],);

          final Column passwordAndVerifyGroupColumn = Column(children: [
            authTextField(
                icon: Icons.lock,
                obscure: true,
                label: 'Password',
                autofocus: false),
            SizedBox(height: 10.0),
            authTextField(
                icon: Icons.lock,
                obscure: true,
                label: 'Verify',
                autofocus: false),
          ],);

          final Row passwordAndVerifyGroupRow = Row(children: [
            Expanded(
              child: authTextField(
                  icon: Icons.lock,
                  obscure: true,
                  label: 'Password',
                  autofocus: false), flex: 10,),
            Expanded(
              child: SizedBox(),
              flex: 1,
            ),
            Expanded(
              child: authTextField(
                  icon: Icons.lock,
                  obscure: true,
                  label: 'Verify',
                  autofocus: false),
              flex: 10,
            ),
          ],);


          return Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50.0),
                isPortrait ? emailAndNameGroupColumn : emailAndNameGroupRow,
                SizedBox(height: isPortrait ? 50.0 : 20),
                Text("Password mest be more 6 characters"),
                SizedBox(height: isPortrait ? 18.0 : 8),
                isPortrait ? passwordAndVerifyGroupColumn : passwordAndVerifyGroupRow,
                SizedBox(height: 30.0),
                authButton(
                    "Create",
                        () {}, color: Colors.brown
                ),
              ],
            ),
          );
        });
  }
}

class _ViewModel {
  final String password;
  final String email;

  final Function(String email, String password) singUp;
  final Function navigateToRegistration;

  _ViewModel({required this.password,
    required this.email,
    required this.singUp,
    required this.navigateToRegistration});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        email: store.state.signInState.email,
        password: store.state.signInState.password,
        singUp: (email, password) {
          store.dispatch(UpdateAuthorizationAction(true));
          store.dispatch(new NavigateToHomeAction());
          //store.dispatch(new ValidateLoginFields(email, password));
        },
        navigateToRegistration: () =>
            store.dispatch(new NavigateToSignUpAction()));
  }
}
