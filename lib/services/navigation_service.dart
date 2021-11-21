import 'package:flutter/cupertino.dart';
import 'package:weekly_bible_trivia/constants/route_paths.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigate(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  void goBack() {
    navigatorKey.currentState!.pop();
  }

  void navigateBack(String routeName) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => route.isCurrent);
  }
}

