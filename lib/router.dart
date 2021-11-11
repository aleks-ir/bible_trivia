import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/screens/home_screen.dart';

import 'constants/route_paths.dart';

class ApplicationRouter {
  Route call(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.HomeScreen:
        return MaterialPageRoute(
            builder: (context){
              return HomeScreen(onInit: () {  },);
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
