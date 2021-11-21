import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/constants/route_paths.dart';
import 'package:weekly_bible_trivia/containers/appbars/simple_app_bar.dart';
import 'package:weekly_bible_trivia/containers/signup_container.dart';
import 'package:weekly_bible_trivia/containers/tab_selector.dart';
import 'package:weekly_bible_trivia/redux/states/app_tab.dart';
import 'package:weekly_bible_trivia/containers/active_tab.dart';
import 'package:weekly_bible_trivia/constants/text_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ActiveTab(
      builder: (BuildContext context, AppTab activeTab) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SimpleAppBar("Create account", RoutePaths.fromSignUpToHomeScreen),
            body: SignUpContainer(),
            ),
          );

}
