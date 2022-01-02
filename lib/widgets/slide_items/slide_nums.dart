import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideNums extends StatelessWidget {
  int index;
  bool isActive;
  bool isAnswered;
  Function() callback;
  Color answeredColor;
  Color unansweredColor;

  SlideNums({required this.index, required this.isActive, required this.isAnswered, required this.callback,
      this.answeredColor: Colors.teal, this.unansweredColor: Colors.black});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
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
