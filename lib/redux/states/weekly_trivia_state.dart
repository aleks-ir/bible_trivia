import 'package:flutter/material.dart';

@immutable
class WeeklyTriviaState {
  final String date;
  final int time;
  final bool isPassed;

  const WeeklyTriviaState({
    required this.date,
    required this.time,
    required this.isPassed,
  });

  WeeklyTriviaState copyWith({
    String? date,
    int? time,
    bool? isPassed,
  }) {
    return WeeklyTriviaState(
      date: date ?? this.date,
      time: time ?? this.time,
      isPassed: isPassed ?? this.isPassed,
    );
  }

  factory WeeklyTriviaState.initial() {
    return const WeeklyTriviaState(
        date: "",
        time: 0,
        isPassed: true,);
  }
}
