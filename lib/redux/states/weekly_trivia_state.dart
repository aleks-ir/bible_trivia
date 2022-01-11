import 'package:flutter/material.dart';

@immutable
class WeeklyTriviaState {
  final String date;
  final int runtime;
  final bool isPassed;

  const WeeklyTriviaState({
    required this.date,
    required this.runtime,
    required this.isPassed,
  });

  WeeklyTriviaState copyWith({
    String? date,
    int? runtime,
    bool? isPassed,
  }) {
    return WeeklyTriviaState(
      date: date ?? this.date,
      runtime: runtime ?? this.runtime,
      isPassed: isPassed ?? this.isPassed,
    );
  }

  factory WeeklyTriviaState.initial() {
    return const WeeklyTriviaState(
        date: "",
        runtime: 0,
        isPassed: true,);
  }
}
