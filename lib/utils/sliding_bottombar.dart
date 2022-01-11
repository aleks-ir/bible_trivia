import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidingBottomNavigationBar extends StatelessWidget{
  SlidingBottomNavigationBar({
    required this.child,
    required this.controller,
    required this.visible,
  });

  final CurvedNavigationBar child;
  final AnimationController controller;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    visible ? controller.reverse() : controller.forward();
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, 1.2)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}