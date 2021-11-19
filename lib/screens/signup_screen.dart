import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/containers/home_container.dart';
import 'package:weekly_bible_trivia/containers/signin_container.dart';
import 'package:weekly_bible_trivia/containers/past_trivia_container.dart';
import 'package:weekly_bible_trivia/containers/reader_container.dart';
import 'package:weekly_bible_trivia/containers/signup_container.dart';
import 'package:weekly_bible_trivia/containers/tab_selector.dart';
import 'package:weekly_bible_trivia/redux/states/app_tab.dart';
import 'package:weekly_bible_trivia/containers/active_tab.dart';
import 'package:weekly_bible_trivia/constants/text_styles.dart';
import 'package:weekly_bible_trivia/widgets/appbars/simple_app_bar.dart';

class SignUpScreen extends StatefulWidget {

  SignUpScreen();

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
          appBar: SimpleAppBar("Create account"),
            body: SignUpContainer(),
            ),
          );

}
