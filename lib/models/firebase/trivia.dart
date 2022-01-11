import 'package:weekly_bible_trivia/models/firebase/question.dart';


class Trivia {
  String book;
  int chapter;
  String date;
  List<Question> questions;
  int runtime;

  Trivia(
      {
        required this.book,
        required this.chapter,
        required this.date,
        required this.questions,
        required this.runtime,
      }
      );

  factory Trivia.fromJson(Map<String, dynamic> json) {

    return Trivia(
        book: json['book'],
        chapter: json['chapter'],
        date: json['date'],
        questions: Question.fromJsonArray(json['questions']),
        runtime: json['runtime'],
    );
  }
}