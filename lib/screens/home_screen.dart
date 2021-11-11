import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/containers/home_container.dart';
import 'package:weekly_bible_trivia/containers/past_trivia_container.dart';
import 'package:weekly_bible_trivia/containers/reader_container.dart';
import 'package:weekly_bible_trivia/containers/tab_selector.dart';
import 'package:weekly_bible_trivia/redux/states/app_tab.dart';
import 'package:weekly_bible_trivia/containers/active_tab.dart';

class HomeScreen extends StatefulWidget {
  final void Function() onInit;

  HomeScreen({required this.onInit});

  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ActiveTab(
      builder: (BuildContext context, AppTab activeTab) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              title: Text('AppBar'),
            ),
            body: _getContainer(activeTab),
            bottomNavigationBar: //TabSelector(),
                Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: const TabSelector(),
            ),
          ));

  dynamic _getContainer(AppTab activeTab) {
    if (activeTab == AppTab.home) {
      return HomeContainer();
    } else if (activeTab == AppTab.reader) {
      return ReaderContainer();
    } else if (activeTab == AppTab.pastTrivia) {
      return PastTriviaContainer();
    }
  }
}
