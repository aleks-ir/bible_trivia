import 'package:weekly_bible_trivia/models/answer.dart';
import 'package:weekly_bible_trivia/models/firebase/question.dart';

class UpdateTriviaDialogAction {
  final bool isShowDialog;
  UpdateTriviaDialogAction(this.isShowDialog);
}

class UpdateIsTimeTriviaAction {
  final bool isTimeTrivia;
  UpdateIsTimeTriviaAction(this.isTimeTrivia);
}


class UpdateCurrentPageAction {
  final int currentPage;
  UpdateCurrentPageAction(this.currentPage);
}

class UpdateStartPageAction {
  final int startPage;
  UpdateStartPageAction(this.startPage);
}

class UpdateEndPageAction {
  final int endPage;
  UpdateEndPageAction(this.endPage);
}

class UpdateListQuestionsAction {
  final List<Question> listQuestions;
  UpdateListQuestionsAction(this.listQuestions);
}

class UpdateListCurrentAnswersAction {
  final List<List<Answer>> listCurrentAnswers;
  UpdateListCurrentAnswersAction(this.listCurrentAnswers);
}


class UpdateListAnsweredQuestionsAction {
  final List<bool> listAnsweredQuestions;
  UpdateListAnsweredQuestionsAction(this.listAnsweredQuestions);
}

