import 'package:flutter/material.dart';

SnackBar floatingSnackBar({
  required String title,
  SnackBarAction? action,
  EdgeInsets margin = const EdgeInsets.only(bottom: 20, left: 30, right: 30),
  double radius = 10,
  int durationSeconds = 2,
  double elevation = 3,
  Color? color,
  Color? textColor,
}) {
  return SnackBar(
    content: Text(
      title,
      style: TextStyle(color: textColor, fontSize: 12),
    ),
    backgroundColor: color,
    duration: Duration(seconds: durationSeconds),
    elevation: elevation,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius))),
    behavior: SnackBarBehavior.floating,
    margin: margin,
    action: action,
  );
}
