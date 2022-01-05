class Result {
  int countQuestions;
  int countCorrectAnswers;
  int countWrongAnswers;
  int countSkippedAnswers;
  List<String> listStateAnswers;

  Result(this.countQuestions, this.countCorrectAnswers, this.countWrongAnswers,
      this.countSkippedAnswers, this.listStateAnswers);
}
