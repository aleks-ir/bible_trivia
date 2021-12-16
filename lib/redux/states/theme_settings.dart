import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/app_colors.dart';

@immutable
class ThemeSettingsState {
  final int primaryColor;
  final int secondaryColor;
  final int appBarColor;
  final int shadowColor;
  final int textColor;
  final int iconColor;

  const ThemeSettingsState({
    required this.primaryColor,
    required this.secondaryColor,
    required this.appBarColor,
    required this.shadowColor,
    required this.textColor,
    required this.iconColor,
  });

  ThemeSettingsState copyWith({
    int? primaryColor,
    int? secondaryColor,
    int? appBarColor,
    int? shadowColor,
    int? textColor,
    int? iconColor,
  }) {
    return ThemeSettingsState(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      appBarColor: appBarColor ?? this.appBarColor,
      shadowColor: shadowColor ?? this.shadowColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  factory ThemeSettingsState.initial() {
    return ThemeSettingsState(
      primaryColor: AppColors.whiteDefault,
      secondaryColor: Colors.black12.value,
      appBarColor: AppColors.whiteDefault,
      shadowColor: Colors.black54.value,
      textColor: AppColors.blackDefault,
      iconColor: Colors.teal.value,
    );
  }
}
