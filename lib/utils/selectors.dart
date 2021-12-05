import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/app_colors.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/models/app_theme.dart';

AppTheme selectTheme(ThemeType themeType) {
  switch (themeType) {
    case ThemeType.dark:
      return AppTheme(
          primaryColor: AppColors.greyDark,
          secondaryColor: Colors.black38.value,
          appBarColor: AppColors.greyDark,
          shadowColor: Colors.white.value,
          textColor: AppColors.whiteDefault);
    default:
      return AppTheme(
          primaryColor: AppColors.whiteDefault,
          secondaryColor: AppColors.greyLightest,
          appBarColor: AppColors.whiteDefault,
          shadowColor: Colors.black54.value,
          textColor: AppColors.blackDefault);
  }
}

