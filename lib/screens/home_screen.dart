import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weekly_bible_trivia/containers/active_tab.dart';
import 'package:weekly_bible_trivia/containers/appbars/active_appbar.dart';
import 'package:weekly_bible_trivia/containers/appbars/active_menubar.dart';
import 'package:weekly_bible_trivia/containers/home_container.dart';
import 'package:weekly_bible_trivia/containers/loading_app.dart';
import 'package:weekly_bible_trivia/containers/past_trivia_container.dart';
import 'package:weekly_bible_trivia/containers/reader_container.dart';
import 'package:weekly_bible_trivia/containers/tab_selector.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    super.initState();
    _initLanguage();
  }

  _initLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String language = prefs.getString(LANGUAGE) ?? "";
    if (language == Language.russian.toString()) {
      I18n.of(context).locale = Locale("ru");
    } else {
      I18n.of(context).locale = Locale("en");
    }
  }

  @override
  Widget build(BuildContext context) => LoadingApp(
        builder: (BuildContext context, bool loading) => ActiveTab(
            builder: (BuildContext context, NavigationTab activeTab) => loading
                ? //     ? MaterialApp(
                Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                      child:
                      //Image.asset('assets/images/logo.png'),
                      CircularProgressIndicator(),
                    ),
                  )
                : Scaffold(
                    appBar: ActiveAppBar(),
                    body: Scaffold(
                      extendBodyBehindAppBar: true,
                      resizeToAvoidBottomInset: false,
                      appBar: ActiveMenuBar(_controller),
                      body: _getContainer(activeTab),
                      bottomNavigationBar: //TabSelector(),
                          Theme(
                        data: Theme.of(context)
                            .copyWith(canvasColor: Colors.transparent),
                        child: const TabSelector(),
                      ),
                    ),
                  )),
      );

  dynamic _getContainer(NavigationTab activeTab) {
    if (activeTab == NavigationTab.home) {
      return HomeContainer();
    } else if (activeTab == NavigationTab.reader) {
      return ReaderContainer();
    } else if (activeTab == NavigationTab.pastTrivia) {
      return PastTriviaContainer();
    }
  }
}
