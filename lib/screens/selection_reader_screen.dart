
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/containers/bars/selection_appbar.dart';
import 'package:weekly_bible_trivia/containers/selection_reader_container.dart';


class SelectionReaderScreen extends StatefulWidget {
  const SelectionReaderScreen({Key? key}) : super(key: key);

  @override
  SignInScreenState createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SelectionReaderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SelectionReaderAppBar(),
          body: SelectionReaderContainer(),
      );
}
