import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/firebase/question.dart';

@immutable
class WeeklyTriviaState {
  final String date;
  final int runtime;
  final bool isPassed;
  final bool isAccessTrivia;
  final String messageError;
  final List<Question> questions;

  const WeeklyTriviaState({
    required this.date,
    required this.runtime,
    required this.isPassed,
    required this.isAccessTrivia,
    required this.messageError,
    required this.questions,
  });

  WeeklyTriviaState copyWith({
    String? date,
    int? runtime,
    bool? isPassed,
    bool? isAccessTrivia,
    String? messageError,
    List<Question>? questions,
  }) {
    return WeeklyTriviaState(
        date: date ?? this.date,
        runtime: runtime ?? this.runtime,
        isPassed: isPassed ?? this.isPassed,
        isAccessTrivia: isAccessTrivia ?? this.isAccessTrivia,
        messageError: messageError ?? this.messageError,
        questions:
            questions ?? this.questions);
  }

  factory WeeklyTriviaState.initial() {
    return const WeeklyTriviaState(
      date: "",
      runtime: 0,
      isPassed: true,
      isAccessTrivia: false,
      messageError: '',
      questions: [],
    );
  }
}
