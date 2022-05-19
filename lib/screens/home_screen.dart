import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weekly_bible_trivia/containers/active_container.dart';
import 'package:weekly_bible_trivia/containers/bars/active_appbar.dart';
import 'package:weekly_bible_trivia/containers/bars/active_menubar.dart';
import 'package:weekly_bible_trivia/containers/loading_app.dart';
import 'package:weekly_bible_trivia/containers/tab_selector.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/widgets/splash.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationControllerMenuBar;
  late final AnimationController _animationControllerAppBar;
  late final AnimationController _animationControllerBottomNavigationBar;

  @override
  void initState() {
    _animationControllerMenuBar = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationControllerAppBar = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationControllerBottomNavigationBar = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _initLanguage();
    super.initState();

  }

  @override
  void dispose(){
    _animationControllerMenuBar.dispose();
    _animationControllerAppBar.dispose();
    _animationControllerBottomNavigationBar.dispose();
    super.dispose();
  }


  _initLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String language = prefs.getString(LANGUAGE) ?? "";
    if (language == RUSSIAN) {
      I18n.of(context).locale = const Locale("ru");
    } else {
      I18n.of(context).locale = const Locale("en");
    }
  }

  @override
  Widget build(BuildContext context) => LoadingApp(
        (BuildContext context, bool loading) => loading
                ? Scaffold(
                    backgroundColor: Colors.white,
                    body: splash(Image.asset(LOGO_IMG, width: 60, height: 60,),),
                  )
                : Scaffold(
                    extendBodyBehindAppBar: true,
                    appBar: ActiveAppBar(_animationControllerAppBar),
                    body: Scaffold(
                      extendBody: true,
                      extendBodyBehindAppBar: true,
                      resizeToAvoidBottomInset: false,
                      appBar: ActiveMenuBar(_animationControllerMenuBar),
                      body: const ActiveContainer(),
                      bottomNavigationBar:
                          Theme(
                        data: Theme.of(context)
                            .copyWith(canvasColor: Colors.transparent),
                        child: TabSelector(_animationControllerBottomNavigationBar),
                      ),
                    ),
                  ),
      );
}
