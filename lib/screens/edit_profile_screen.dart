import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/route_paths.dart';
import 'package:weekly_bible_trivia/containers/active_tab.dart';
import 'package:weekly_bible_trivia/containers/appbars/simple_appbar.dart';
import 'package:weekly_bible_trivia/containers/signin_container.dart';
import 'package:weekly_bible_trivia/models/enums.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);



  @override
  SignInScreenState createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ActiveTab(
        builder: (BuildContext context, NavigationTab activeTab) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SimpleAppBar("Edit profile", RoutePaths.fromEditProfileToHomeScreen),
          body: SignInContainer(),
        ),
      );
}
