import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/screens/signup_screen.dart';
import 'package:weekly_bible_trivia/screens/home_screen.dart';
import 'package:weekly_bible_trivia/screens/signin_screen.dart';

import '../constants/route_paths.dart';

class ApplicationRouter {
  Route call(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.HomeScreen:
        return MaterialPageRoute(
            builder: (context){
              return HomeScreen();
            });
      case RoutePaths.SignInScreen:
        return MaterialPageRoute(
            builder: (context){
              return SignInScreen();
            });
      case RoutePaths.SignUpScreen:
        return MaterialPageRoute(
            builder: (context){
              return SignUpScreen();
            });
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                    body: Center(
                  child: Text('Route ${settings.name} is not deffined'),
                )));
    }
  }
}
