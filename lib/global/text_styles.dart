import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle getButtonMoreTextStyle(Color color)
  {return TextStyle(
    fontSize: 18,
    color: color,
    fontWeight: FontWeight.w700,
  );}


  static TextStyle getAppBarStyle(Color color)
  {return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w300,
      color: color
  );}
}
