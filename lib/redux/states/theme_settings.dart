import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class ThemeSettingsState {
  final int primaryColor;
  final int secondaryColor;
  final int appBarColor;
  final int shadowColor;
  final int textColor;

  const ThemeSettingsState({
    required this.primaryColor,
    required this.secondaryColor,
    required this.appBarColor,
    required this.shadowColor,
    required this.textColor,
  });

  ThemeSettingsState copyWith({
    int? primaryColor,
    int? secondaryColor,
    int? appBarColor,
    int? shadowColor,
    int? textColor,
  }) {
    return ThemeSettingsState(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      appBarColor: appBarColor ?? this.appBarColor,
      shadowColor: shadowColor ?? this.shadowColor,
      textColor: textColor ?? this.textColor,
    );
  }

  factory ThemeSettingsState.initial() {
    return ThemeSettingsState(
      secondaryColor: Colors.white.value,
      appBarColor: Colors.white.value,
      textColor: Colors.black.value,
      shadowColor: Colors.black38.value,
      primaryColor: Colors.white.value,
    );
  }
}
