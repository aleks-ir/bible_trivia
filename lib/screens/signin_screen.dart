
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/containers/appbars/simple_appbar.dart';
import 'package:weekly_bible_trivia/containers/signin_container.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);



  @override
  SignInScreenState createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>  Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SimpleAppBar(authorization.i18n, NavigateFromSignInToHomeScreenAction()),
          body: SignInContainer(),
      );
}
