import 'package:flutter/cupertino.dart';

class SlidingMenuBar extends StatelessWidget implements PreferredSizeWidget {
  SlidingMenuBar({
    required this.child,
    required this.controller,
    required this.visible,
  });

  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool visible;

  @override
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    visible ? controller.forward() : controller.reverse();
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0, -2), end: Offset.zero).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}