
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/containers/appbars/simple_appbar.dart';
import 'package:weekly_bible_trivia/containers/search_container.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);



  @override
  SignInScreenState createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SimpleAppBar(search.i18n, NavigateFromSearchToHomeScreenAction()),
          body: SearchContainer(),
      );
}
