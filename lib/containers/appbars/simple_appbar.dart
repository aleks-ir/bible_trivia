import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/text_styles.dart';
import 'package:weekly_bible_trivia/services/navigation_service.dart';
import 'package:weekly_bible_trivia/utils/locator.dart';

class SimpleAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final String routeName;

  final NavigationService _navigationService = locator<NavigationService>();

  @override
  final Size preferredSize;

  SimpleAppBar(
    this.title, this.routeName, {
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
          onPressed: () => _navigationService.navigateBack(routeName)
      ),],
      title: Text(this.title, style: TextStyles.appBarStyle),
      backgroundColor: Colors.white,
    );
  }
}
