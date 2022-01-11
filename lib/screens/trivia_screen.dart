
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/containers/trivia_container.dart';


class TriviaScreen extends StatelessWidget {
  const TriviaScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async => false,
    child: const Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: null,
            body: TriviaContainer(),
        ),
  );
}
