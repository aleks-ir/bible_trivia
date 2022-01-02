
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/containers/appbars/simple_appbar.dart';
import 'package:weekly_bible_trivia/containers/trivia_container.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';


class TriviaScreen extends StatefulWidget {
  const TriviaScreen({Key? key}) : super(key: key);



  @override
  _TriviaScreenState createState() {
    return _TriviaScreenState();
  }
}

class _TriviaScreenState extends State<TriviaScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async => false,
    child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: null,
            body: TriviaContainer(),
        ),
  );
}
