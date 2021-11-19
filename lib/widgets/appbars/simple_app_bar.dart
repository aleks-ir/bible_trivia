import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/constants/route_paths.dart';
import 'package:weekly_bible_trivia/constants/text_styles.dart';
import 'package:weekly_bible_trivia/screens/home_screen.dart';

class SimpleAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  @override
  final Size preferredSize;

  SimpleAppBar(
    this.title, {
    Key? key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [IconButton(
        icon: Transform.rotate(
          angle: 90 * pi/180,
          child: Icon(Icons.chevron_right, color: Colors.black),
        ),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => route.isCurrent),
      ),],
      title: Text(this.title, style: TextStyles.appBarStyle),
      backgroundColor: Colors.white,
    );
  }
}
