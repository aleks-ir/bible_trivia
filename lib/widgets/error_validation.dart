import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/constants/colors.dart';

Widget errorValidation(String textError) =>  Text(textError,
    style: const TextStyle(
        fontSize: 10.0,
        color: Color(error_red)
    ),
);