import 'package:flutter/material.dart';

class BrandColors {
  static const defaultBgrGradient = LinearGradient(
    colors: [
      Color(0xFF9932CC),
      Color(0xFF6A5ACD),
    ],
  );

  static const List<Gradient> theListOfAvalibleGradients = [
    LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.indigoAccent,
        Colors.teal,
      ],
    ),
    LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.deepPurple,
        Colors.purple,
      ],
    ),
    LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(249, 161, 154, 1),
        Colors.pinkAccent,
      ],
    ),
  ];
}
