import 'package:meta/meta.dart';

@immutable
class InfoTriviaState {
  final String book;
  final String chapters;
  final String date;
  final int countQuestion;
  final int time;

  InfoTriviaState({required this.book, required this.chapters, required this.date, required this.countQuestion, required this.time});

  InfoTriviaState copyWith(
      {String? book,
      String? chapters,
      String? date,
      int? countQuestion,
      int? time,}) {
    return InfoTriviaState(
        book: book ?? this.book,
    chapters: chapters ?? this.chapters,
    date: date ?? this.date,
    countQuestion: countQuestion ?? this.countQuestion,
    time: time ?? this.time);
  }

  factory InfoTriviaState.initial() {
    return InfoTriviaState(
      book: "—",
      chapters: "—",
      date: "—",
      countQuestion: 30,
      time: 600,
    );
  }
}
