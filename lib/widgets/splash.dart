import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/widgets/progress_indicators.dart';

Widget splash(Image image) {
  return Stack(
    children: [
      Align(
        child: image,
        alignment: Alignment.center,
      ),
      Align(
        alignment: Alignment.center,
        child: splashCircularProgressIndicator(),
      )
    ],
  );
}
