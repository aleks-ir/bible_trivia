import 'package:flutter/cupertino.dart';

class SlidingAppBar extends StatelessWidget implements PreferredSizeWidget {
  SlidingAppBar({
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
      position: Tween<Offset>(begin: Offset(0, -1), end: Offset.zero).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}