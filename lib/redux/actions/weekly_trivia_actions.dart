import 'package:weekly_bible_trivia/models/firebase/question.dart';

class UpdateWeeklyTriviaDateAction {
  final String date;
  UpdateWeeklyTriviaDateAction(this.date);
}

class UpdateRuntimeAction {
  final int runtime;
  UpdateRuntimeAction(this.runtime);
}

class UpdateWeeklyTriviaPassedAction {
  final bool isPassed;
  UpdateWeeklyTriviaPassedAction(this.isPassed);
}

class UpdateAccessWeeklyTriviaAction {
  final bool isAccessTrivia;
  UpdateAccessWeeklyTriviaAction(this.isAccessTrivia);
}

class AccessWeeklyTriviaErrorAction {
  final String message;
  AccessWeeklyTriviaErrorAction(this.message);
}

class UpdateWeeklyTriviaQuestionsAction {
  final List<Question> questions;
  UpdateWeeklyTriviaQuestionsAction(this.questions);
}
