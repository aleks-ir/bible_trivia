import 'package:flutter/material.dart';

@immutable
class HomeState {
  final String title;

  const HomeState({
    required this.title,
  });

  HomeState copyWith({String? title}) {
    return HomeState(
      title: title ?? this.title,
    );
  }
}
