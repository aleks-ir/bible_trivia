import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultCircularProgressIndicator(Color color) => CircularProgressIndicator(
  strokeWidth: 5,
  valueColor:
  AlwaysStoppedAnimation<Color>(color.withOpacity(0.5)),
);

Widget miniCircularProgressIndicator() => SizedBox(
  height: 25,
  width: 25,
  child:   CircularProgressIndicator(
    strokeWidth: 5,
    valueColor:
    AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(0.5)),
  ),
);

Widget maxCircularProgressIndicator() => SizedBox(
  width: 130,
  height: 130,
  child: CircularProgressIndicator(
    strokeWidth: 5,
    valueColor:
    AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(0.2)),
  ),
);


