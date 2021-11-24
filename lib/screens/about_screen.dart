
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/constants/enums/navigation_tabs.dart';
import 'package:weekly_bible_trivia/constants/route_paths.dart';
import 'package:weekly_bible_trivia/containers/active_tab.dart';
import 'package:weekly_bible_trivia/containers/appbars/simple_appbar.dart';
import 'package:weekly_bible_trivia/containers/signin_container.dart';


class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);



  @override
  SignInScreenState createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ActiveTab(
        builder: (BuildContext context, NavigationTab activeTab) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SimpleAppBar("About", RoutePaths.fromAboutToHomeScreen),
          body: SignInContainer(),
        ),
      );
}
