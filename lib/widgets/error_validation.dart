import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/app_colors.dart';

Widget errorValidation(String textError) =>  Padding(
  padding: const EdgeInsets.only(top: 2.0),
  child:   Text(textError,
      style: const TextStyle(
          fontSize: 10.0,
          color: Color(AppColors.error_red)
      ),
  ),
);