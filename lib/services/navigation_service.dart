import 'package:flutter/cupertino.dart';
import 'package:weekly_bible_trivia/constants/route_paths.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  void goBack() {
    navigatorKey.currentState!.pop();
  }

  void goBackTo(String routeName) {
    navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
