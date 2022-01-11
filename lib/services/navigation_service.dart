import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/screens/home_screen.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigate(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  void goBack() {
    navigatorKey.currentState!.pop();
  }

  void navigateBack(String routeName) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  void navigateAndReplace(String routeName) {
    navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}

