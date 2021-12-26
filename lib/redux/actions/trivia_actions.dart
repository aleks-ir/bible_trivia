

import 'package:weekly_bible_trivia/models/firestore/question.dart';

class UpdateIsPastTriviaAction {
  final bool isPastTrivia;
  UpdateIsPastTriviaAction(this.isPastTrivia);
}

class UpdateListQuestionsAction {
  final List<Question> listQuestions;
  UpdateListQuestionsAction(this.listQuestions);
}


class UpdateListSkipQuestionsAction {
  final List<int> listSkipQuestions;
  UpdateListSkipQuestionsAction(this.listSkipQuestions);
}

