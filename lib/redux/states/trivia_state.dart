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
  final List<Question> listQuestions;
  final List<List<Answer>> listCurrentAnswers;
  final List<bool> listAnsweredQuestions;

  const TriviaState({
    required this.isShowDialog,
    required this.isTimeTrivia,
    required this.currentPage,
    required this.startPage,
    required this.endPage,
    required this.listQuestions,
    required this.listCurrentAnswers,
    required this.listAnsweredQuestions,
  });

  TriviaState copyWith({
    bool? isShowDialog,
    bool? isTimeTrivia,
    int? currentPage,
    int? startPage,
    int? endPage,
    List<Question>? listQuestions,
    List<List<Answer>>? listCurrentAnswers,
    List<bool>? listAnsweredQuestions,
  }) {
    return TriviaState(
      isShowDialog: isShowDialog ?? this.isShowDialog,
      isTimeTrivia: isTimeTrivia ?? this.isTimeTrivia,
      currentPage: currentPage ?? this.currentPage,
      startPage: startPage ?? this.startPage,
      endPage: endPage ?? this.endPage,
      listQuestions: listQuestions ?? this.listQuestions,
      listCurrentAnswers: listCurrentAnswers ?? this.listCurrentAnswers,
      listAnsweredQuestions: listAnsweredQuestions ?? this.listAnsweredQuestions,
    );
  }

  factory TriviaState.initial() {
    return const TriviaState(
        isShowDialog: false,
        isTimeTrivia: false,
        currentPage: 0,
        startPage: 0,
        endPage: 10,
        listQuestions: [],
        listCurrentAnswers: [],
        listAnsweredQuestions: []);
  }
}
