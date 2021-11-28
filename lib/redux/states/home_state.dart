import 'package:flutter/material.dart';

@immutable
class HomeState {
  final bool isShowedInfoTrivia;

  const HomeState({
    required this.isShowedInfoTrivia,
  });

  HomeState copyWith({
    bool? isShowedInfoTrivia}) {
    return HomeState(
      isShowedInfoTrivia: isShowedInfoTrivia ?? this.isShowedInfoTrivia,
    );
  }

  factory HomeState.initial() {
    return HomeState(
        isShowedInfoTrivia: false);
  }
}
