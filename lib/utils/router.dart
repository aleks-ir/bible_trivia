import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/constants/enums/animation_direction.dart';
import 'package:weekly_bible_trivia/screens/about_screen.dart';
import 'package:weekly_bible_trivia/screens/edit_profile_screen.dart';
import 'package:weekly_bible_trivia/screens/main_screen.dart';
import 'package:weekly_bible_trivia/screens/signin_screen.dart';
import 'package:weekly_bible_trivia/screens/signup_screen.dart';
import 'package:weekly_bible_trivia/screens/table_results_screen.dart';
import 'package:weekly_bible_trivia/utils/animation_page_route.dart';

import '../constants/route_paths.dart';

class ApplicationRouter {
  Route call(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.toMainScreen:
        return MaterialPageRoute(
            builder: (context){
              return const MainScreen();
            });
      case RoutePaths.fromHomeToSignInScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const SignInScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToTableResultsScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const TableResultsScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToAboutScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const AboutScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToEditProfileScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const EditProfileScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToMainTriviaScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToPastTriviaScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToSearchScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToSetChapterScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToSetTranslationScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromSignInToHomeScreen:
        return AnimationPageRoute(startPage: const SignInScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromSignInToSignUpScreen:
        return AnimationPageRoute(startPage: const SignInScreen(), endPage: const SignUpScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromSignUpToHomeScreen:
        return AnimationPageRoute(startPage: const SignUpScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromTableResultsToHomeScreen:
        return AnimationPageRoute(startPage: const TableResultsScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromAboutToHomeScreen:
        return AnimationPageRoute(startPage: const AboutScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromEditProfileToHomeScreen:
        return AnimationPageRoute(startPage: const EditProfileScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromMainTriviaToResultScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromPastTriviaToResultScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromResultToHomeScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromSearchToHomeScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromSetChapterToHomeScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromSetTranslationToHomeScreen:
        return AnimationPageRoute(startPage: const MainScreen(), endPage: const MainScreen(), animationDirection: AnimationDirection.downward);

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                    body: Center(
                  child: Text('Route ${settings.name} is not deffined'),
                )));
    }
  }
}

