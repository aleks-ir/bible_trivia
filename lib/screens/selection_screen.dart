
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/containers/appbars/selection_appbar.dart';
import 'package:weekly_bible_trivia/containers/selection_container.dart';


class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);



  @override
  SignInScreenState createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SelectionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SelectionAppBar(),
          body: SelectionContainer(),
      );
}
