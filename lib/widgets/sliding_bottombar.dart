import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidingBottomNavigationBar extends StatelessWidget{
  SlidingBottomNavigationBar({
    required this.child,
    required this.controller,
    required this.visible,
  });

  final BottomNavigationBar child;
  final AnimationController controller;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    visible ? controller.reverse() : controller.forward();
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, 1)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}