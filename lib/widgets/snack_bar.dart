import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, {Color color: Colors.teal, Color textColor: Colors.white}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message, style: TextStyle(color: textColor),),
    backgroundColor: color,
  ));
}