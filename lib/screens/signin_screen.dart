
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/containers/bars/simple_appbar.dart';
import 'package:weekly_bible_trivia/containers/signin_container.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';


class SignInScreen extends StatelessWidget {
  final bool isErrorListener;

  const SignInScreen(this.isErrorListener, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>  Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SimpleAppBar(authorization.i18n, NavigateFromSignInToHomeScreenAction()),
          body: SignInContainer(isErrorListener),
      );
}
