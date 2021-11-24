import 'package:flutter/material.dart';

MaterialButton authButton(Widget childWidget, VoidCallback callback,
    {Color color: const Color(0xfff063057), Color textColor: Colors.white}) {
  return MaterialButton(
    onPressed: callback,
    textColor: textColor,
    color: color,
    child: SizedBox(
      child: childWidget,
    ),
    height: 45,
    minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}