import 'package:flutter/cupertino.dart';

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

