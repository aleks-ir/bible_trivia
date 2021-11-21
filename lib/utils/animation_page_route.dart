import 'package:flutter/cupertino.dart';
import 'package:weekly_bible_trivia/constants/enums/animation_direction.dart';

class AnimationPageRoute extends PageRouteBuilder {
  final Widget endPage;
  final Widget startPage;
  final AnimationDirection animationDirection;
  AnimationPageRoute({required this.startPage, required this.endPage, required this.animationDirection})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    endPage,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        Stack(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: Offset(0.0, animationDirection == AnimationDirection.upward ? 0.0 : 0.0),
              ).animate(animation),
              child: startPage,
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, animationDirection == AnimationDirection.upward ? 1.0 : -1.0),
                end: Offset.zero,
              ).animate(animation),
              child: endPage,
            )
          ],
        ),
  );
}