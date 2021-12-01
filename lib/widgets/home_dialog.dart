import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget homeDialog(
    {double padding: 20,
    double avatarRadius: 30,
    required VoidCallback onPressed,
    required Image image,
    Color color: Colors.white,
    Color textColor: Colors.black}) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(padding),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    child: Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: padding,
              top: padding + 30,
              right: padding,
              bottom: padding),
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: color,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 2), blurRadius: 10),
              ]),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sign in to begin the trivia, please.",
                  style: TextStyle(fontSize: 16, color: textColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: onPressed,
                      child: Text(
                        "Close",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      )),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          //top: 15,
          left: 0,
          right: 0,
          child: CircleAvatar(
              backgroundColor: Colors.transparent, radius: 30, child: image),
        )
      ],
    ),
  );
}
