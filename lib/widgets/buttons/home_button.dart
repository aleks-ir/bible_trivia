import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget  animatedHomeButton({required String title, double height: 100,
  double width: 100,}) {
  return Container(
    height: width,
    width: height,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          BoxShadow(
            color: Colors.green,
            blurRadius: 6.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.greenAccent,
            Colors.teal,
          ],
        )),
    child: Center(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    ),
  );
}