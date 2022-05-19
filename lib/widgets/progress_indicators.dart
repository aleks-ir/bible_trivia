import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultCircularProgressIndicator(Color color) =>
    CircularProgressIndicator(
      strokeWidth: 3,
      valueColor: AlwaysStoppedAnimation<Color>(color.withOpacity(0.5)),
    );

Widget circularButtonProgressIndicator(
        {double size = 25, Color? color}) =>
    SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor:
            AlwaysStoppedAnimation<Color>(color ?? Colors.white.withOpacity(0.5)),
      ),
    );

Widget splashCircularProgressIndicator() => SizedBox(
      width: 90,
      height: 90,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor:
            AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(0.2)),
      ),
    );
