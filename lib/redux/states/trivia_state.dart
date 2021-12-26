import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/firestore/question.dart';

@immutable
class TriviaState {
  final bool isPastTrivia;
  final List<Question> listQuestions;
  final List<int> listSkipQuestions;

  const TriviaState({
    required this.isPastTrivia,
    required this.listQuestions,
    required this.listSkipQuestions,
  });

  TriviaState copyWith({
    bool? isPastTrivia,
    List<Question>? listQuestions,
    List<int>? listSkipQuestions,
  }) {
    return TriviaState(
      isPastTrivia: isPastTrivia ?? this.isPastTrivia,
      listQuestions: listQuestions ?? this.listQuestions,
      listSkipQuestions: listSkipQuestions ?? this.listSkipQuestions,
    );
  }

  factory TriviaState.initial() {
    return const TriviaState(
        isPastTrivia: true,
        listQuestions: [],
        listSkipQuestions: []);
  }
}
