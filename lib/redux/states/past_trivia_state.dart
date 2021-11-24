import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/constants/strings.dart';

@immutable
class PastTriviaState {
  final List<String> books;
  final int selectedBook;

  const PastTriviaState({
    required this.books,
    required this.selectedBook,
  });

  PastTriviaState copyWith({
    List<String>? books,
    int? selectedBook,}) {
    return PastTriviaState(
      selectedBook: selectedBook ?? this.selectedBook,
      books: books ?? this.books,
    );
  }

  factory PastTriviaState.initial() {
    return PastTriviaState(
      selectedBook: 1,
      books: TEST_BOOKS,);
  }
}
