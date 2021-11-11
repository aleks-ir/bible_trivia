import 'package:flutter/material.dart';

@immutable
class PastTriviaState {
  final String title;

  const PastTriviaState({
    required this.title,
  });

  PastTriviaState copyWith({required String title}) {
    return PastTriviaState(
      title: this.title,
    );
  }
}
