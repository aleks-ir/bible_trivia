import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/route_paths.dart';
import 'package:weekly_bible_trivia/screens/about_screen.dart';
import 'package:weekly_bible_trivia/screens/edit_profile_screen.dart';
import 'package:weekly_bible_trivia/screens/home_screen.dart';
import 'package:weekly_bible_trivia/screens/result_screen.dart';
import 'package:weekly_bible_trivia/screens/search_screen.dart';
import 'package:weekly_bible_trivia/screens/selection_screen.dart';
import 'package:weekly_bible_trivia/screens/signin_screen.dart';
import 'package:weekly_bible_trivia/screens/signup_screen.dart';
import 'package:weekly_bible_trivia/screens/table_results_screen.dart';
import 'package:weekly_bible_trivia/screens/translation_screen.dart';
import 'package:weekly_bible_trivia/screens/trivia_screen.dart';
import 'package:weekly_bible_trivia/utils/animation_page.dart';


class ApplicationRouter {
  Route call(RouteSettings settings) {
      switch (settings.name) {
        case RoutePaths.toHomeScreen:
          return MaterialPageRoute(builder: (context) =>
              const HomeScreen());
        case RoutePaths.fromHomeToSignInScreen:
          return AnimationPage(startPage: const HomeScreen(), endPage: SignInScreen(true), animationDirection: AnimationDirection.upward);
        case RoutePaths.fromHomeToTableResultsScreen:
          return AnimationPage(startPage: const HomeScreen(), endPage: const TableResultsScreen(), animationDirection: AnimationDirection.upward);
        case RoutePaths.fromHomeToAboutScreen:
          return AnimationPage(startPage: const HomeScreen(), endPage: const AboutScreen(), animationDirection: AnimationDirection.upward);
        case RoutePaths.fromHomeToEditProfileScreen:
          return AnimationPage(startPage: const HomeScreen(), endPage: const EditProfileScreen(), animationDirection: AnimationDirection.upward);
        case RoutePaths.fromHomeToTriviaScreen:
          return AnimationPage(startPage: const HomeScreen(), endPage: const TriviaScreen(), animationDirection: AnimationDirection.upward);
        case RoutePaths.fromHomeToSearchScreen:
          return AnimationPage(startPage: const HomeScreen(), endPage: const SearchScreen(), animationDirection: AnimationDirection.upward);
        case RoutePaths.fromHomeToSelectionReaderScreen:
          return AnimationPage(startPage: const HomeScreen(), endPage: const SelectionReaderScreen(), animationDirection: AnimationDirection.upward);
        case RoutePaths.fromSelectionReaderToTranslationScreen:
          return AnimationPage(startPage: const SelectionReaderScreen(), endPage: const TranslationScreen(), animationDirection: AnimationDirection.upward);
        case RoutePaths.fromSignInToHomeScreen:
          //return MaterialPageRoute(builder: (context) =>
          //const HomeScreen());
          return AnimationPage(startPage: SignInScreen(false), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
        case RoutePaths.fromSignInToSignUpScreen:
          return AnimationPage(startPage: SignInScreen(false), endPage: const SignUpScreen(), animationDirection: AnimationDirection.upward);
        case RoutePaths.fromSignUpToHomeScreen:
          return AnimationPage(startPage: const SignUpScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
        case RoutePaths.fromTableResultsToHomeScreen:
          return AnimationPage(startPage: const TableResultsScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
        case RoutePaths.fromAboutToHomeScreen:
          return AnimationPage(startPage: const AboutScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
        case RoutePaths.fromEditProfileToHomeScreen:
          return AnimationPage(startPage: const EditProfileScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
        case RoutePaths.fromTriviaToResultScreen:
          return MaterialPageRoute(builder: (context) =>
          const ResultScreen());
        case RoutePaths.fromTriviaToHomeScreen:
          return AnimationPage(startPage: const TriviaScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
        case RoutePaths.fromResultToHomeScreen:
          return AnimationPage(startPage: const ResultScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
        case RoutePaths.fromSearchToHomeScreen:
          return AnimationPage(startPage: const SearchScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
        case RoutePaths.fromSelectionReaderToHomeScreen:
          return AnimationPage(startPage: const SelectionReaderScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
        case RoutePaths.fromTranslationToSelectionScreen:
          return AnimationPage(startPage: const TranslationScreen(), endPage: const SelectionReaderScreen(), animationDirection: AnimationDirection.downward);
        case RoutePaths.fromTranslationToHomeScreen:
          return AnimationPage(startPage: const TranslationScreen(), endPage: const HomeScreen(), animationDirection: AnimationDirection.downward);
        default:
          return MaterialPageRoute(
              builder: (context) => Scaffold(
                      body: Center(
                    child: Text('Route ${settings.name} is not deffined'),
                  )));
      }
  }
}

