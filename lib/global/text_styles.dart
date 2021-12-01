import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle getButtonMoreTextStyle(Color color)
  {return TextStyle(
    fontSize: 20,
    color: color,
    fontWeight: FontWeight.w700,
  );}




  static TextStyle getAppBarStyle(Color color)
  {return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w300,
      color: color
  );}


  static TextStyle getHomeInfoCardTitleStyle(Color color)
  {return TextStyle(
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
      fontSize: 20,
      color: color
  );}

  static TextStyle getHomeInfoCardStyle(Color color)
  {return TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15,
    height: 1.3,
    color: color
  );}

}
