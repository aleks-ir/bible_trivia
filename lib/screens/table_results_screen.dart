import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/constants/route_paths.dart';
import 'package:weekly_bible_trivia/containers/appbars/simple_app_bar.dart';
import 'package:weekly_bible_trivia/containers/home_container.dart';
import 'package:weekly_bible_trivia/containers/signin_container.dart';
import 'package:weekly_bible_trivia/containers/past_trivia_container.dart';
import 'package:weekly_bible_trivia/containers/reader_container.dart';
import 'package:weekly_bible_trivia/containers/tab_selector.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_tab.dart';
import 'package:weekly_bible_trivia/containers/active_tab.dart';
import 'package:weekly_bible_trivia/constants/text_styles.dart';

class TableResultsScreen extends StatefulWidget {
  const TableResultsScreen({Key? key}) : super(key: key);


  @override
  SignInScreenState createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<TableResultsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ActiveTab(
        builder: (BuildContext context, AppTab activeTab) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SimpleAppBar("Results", RoutePaths.fromResultToHomeScreen),
          body: SignInContainer(),
        ),
      );
}
