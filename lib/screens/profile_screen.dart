import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/containers/bars/simple_appbar.dart';
import 'package:weekly_bible_trivia/containers/profile_container.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SimpleAppBar(profile.i18n, NavigateFromProfileToHomeScreenAction()),
          body: const ProfileContainer(),
      );
}
