import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/constants/route_paths.dart';
import 'package:weekly_bible_trivia/constants/text_styles.dart';
import 'package:weekly_bible_trivia/screens/home_screen.dart';
import 'package:weekly_bible_trivia/services/navigation_service.dart';
import 'package:weekly_bible_trivia/utils/locator.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  @override
  final Size preferredSize;
  final void Function() func;
  HomeAppBar(
    this.title, this.func, {
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [ IconButton(
        icon: Transform.scale(
          scale: 1.0,
          child: const Icon(Icons.public, color: Colors.black),
        ),
          onPressed: func,
      ),
        const SizedBox(width: 10,),],
      title: Text(title, style: TextStyles.appBarStyle),
      backgroundColor: Colors.white,
    );
  }
}
