import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/answer.dart';
import 'package:weekly_bible_trivia/models/firebase/question.dart';

@immutable
class TriviaState {
  final bool isShowDialog;
  final bool isTimeTrivia;
  final int currentPage;
  final int startPage;
  final int endPage;
  final List<Question> questions;
  final List<List<Answer>> currentAnswers;
  final List<bool> answeredQuestions;

  const TriviaState({
    required this.isShowDialog,
    required this.isTimeTrivia,
    required this.currentPage,
    required this.startPage,
    required this.endPage,
    required this.questions,
    required this.currentAnswers,
    required this.answeredQuestions,
  });

  TriviaState copyWith({
    bool? isShowDialog,
    bool? isTimeTrivia,
    int? currentPage,
    int? startPage,
    int? endPage,
    List<Question>? questions,
    List<List<Answer>>? currentAnswers,
    List<bool>? answeredQuestions,
  }) {
    return TriviaState(
      isShowDialog: isShowDialog ?? this.isShowDialog,
      isTimeTrivia: isTimeTrivia ?? this.isTimeTrivia,
      currentPage: currentPage ?? this.currentPage,
      startPage: startPage ?? this.startPage,
      endPage: endPage ?? this.endPage,
      questions: questions ?? this.questions,
      currentAnswers: currentAnswers ?? this.currentAnswers,
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
    );
  }

  factory TriviaState.initial() {
    return const TriviaState(
        isShowDialog: false,
        isTimeTrivia: false,
        currentPage: 0,
        startPage: 0,
        endPage: 10,
        questions: [],
        currentAnswers: [],
        answeredQuestions: []);
  }
}
