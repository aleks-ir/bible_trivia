import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideNumbers extends StatelessWidget {
  final int index;
  final bool isActive;
  final bool isAnswered;
  final Function() callback;
  final Color answeredColor;
  final Color unansweredColor;

  const SlideNumbers({Key? key, required this.index, required this.isActive, required this.isAnswered, required this.callback,
      this.answeredColor = Colors.teal, this.unansweredColor = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.symmetric(horizontal: 0),
      height: isActive ? 45 : 40,
      child: TextButton(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          padding: EdgeInsets.zero,
        ),
        child: Text(
          (index + 1).toString(),
          style: TextStyle(
              color: isAnswered ? answeredColor : unansweredColor,
              fontSize: isActive ? 17 : 12,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400),
        ),
        onPressed: callback,
      ),
    );
  }
}
