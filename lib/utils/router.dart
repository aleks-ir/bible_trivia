import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/route_paths.dart';
import 'package:weekly_bible_trivia/screens/about_screen.dart';
import 'package:weekly_bible_trivia/screens/edit_profile_screen.dart';
import 'package:weekly_bible_trivia/screens/home_screen.dart';
import 'package:weekly_bible_trivia/screens/signin_screen.dart';
import 'package:weekly_bible_trivia/screens/signup_screen.dart';
import 'package:weekly_bible_trivia/screens/table_results_screen.dart';
import 'package:weekly_bible_trivia/utils/animation_page.dart';


class ApplicationRouter {
  Route call(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.toHomeScreen:
        return MaterialPageRoute(
            builder: (context){
              return const HomeScreen();
            });
      case RoutePaths.fromHomeToSignInScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const SignInScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToTableResultsScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const TableResultsScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToAboutScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const AboutScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToEditProfileScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const EditProfileScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToMainTriviaScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToPastTriviaScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToSearchScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToSetChapterScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromHomeToSetTranslationScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromSignInToHomeScreen:
        return AnimationPage(startPage: const SignInScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromSignInToSignUpScreen:
        return AnimationPage(startPage: const SignInScreen(), endPage: const SignUpScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromSignUpToHomeScreen:
        return AnimationPage(startPage: const SignUpScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromTableResultsToHomeScreen:
        return AnimationPage(startPage: const TableResultsScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromAboutToHomeScreen:
        return AnimationPage(startPage: const AboutScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromEditProfileToHomeScreen:
        return AnimationPage(startPage: const EditProfileScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromMainTriviaToResultScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromPastTriviaToResultScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.upward);
      case RoutePaths.fromResultToHomeScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromSearchToHomeScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromSetChapterToHomeScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
      case RoutePaths.fromSetTranslationToHomeScreen:
        return AnimationPage(startPage: const HomeScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                    body: Center(
                  child: Text('Route ${settings.name} is not deffined'),
                )));
    }
  }
}

