import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultCircularProgressIndicator(Color color) =>
    CircularProgressIndicator(
      strokeWidth: 5,
      valueColor: AlwaysStoppedAnimation<Color>(color.withOpacity(0.5)),
    );

Widget buttonCircularProgressIndicator(
        {Color? color}) =>
    SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        strokeWidth: 5,
        valueColor:
            AlwaysStoppedAnimation<Color>(color ?? Colors.white.withOpacity(0.5)),
      ),
    );

Widget splashCircularProgressIndicator() => SizedBox(
      width: 100,
      height: 100,
      child: CircularProgressIndicator(
        strokeWidth: 5,
        valueColor:
            AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(0.2)),
      ),
    );
