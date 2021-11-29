
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/route_paths.dart';
import 'package:weekly_bible_trivia/containers/active_tab.dart';
import 'package:weekly_bible_trivia/containers/appbars/simple_appbar.dart';
import 'package:weekly_bible_trivia/containers/signin_container.dart';
import 'package:weekly_bible_trivia/models/enums.dart';

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
  Widget build(BuildContext context) => ActiveTab(
        builder: (BuildContext context, NavigationTab activeTab) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SimpleAppBar("Log in", RoutePaths.fromSignInToHomeScreen),
          body: SignInContainer(),
        ),
      );
}
