import 'package:flutter/material.dart';

@immutable
class PastTriviaState {
  final String bookName;
  final int chapter;
  final bool isShowDialog;

  const PastTriviaState({
    required this.bookName,
    required this.chapter,
    required this.isShowDialog,
  });

  PastTriviaState copyWith({
    String? bookName,
    int? chapter,
    bool? isShowDialog,
  }) {
    return PastTriviaState(
      bookName: bookName ?? this.bookName,
      chapter: chapter ?? this.chapter,
      isShowDialog: isShowDialog ?? this.isShowDialog,
    );
  }

  factory PastTriviaState.initial() {
    return const PastTriviaState(
        bookName: "",
        chapter: -1,
        isShowDialog: false,);
  }
}
