class Question {
  List<String> answersEn;
  List<String> answersRu;
  List<int> correctAnswers;
  String explanationEn;
  String explanationRu;
  String questionEn;
  String questionRu;

  Question({
    required this.answersEn,
    required this.answersRu,
    required this.correctAnswers,
    required this.explanationEn,
    required this.explanationRu,
    required this.questionEn,
    required this.questionRu,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      answersEn: (json['answers_en'] as List).map((item) => item as String).toList(),
      answersRu: (json['answers_ru'] as List).map((item) => item as String).toList(),
      correctAnswers: (json['correct_answer'] as List).map((item) => item as int).toList(),
      explanationEn: json['explanation_en'],
      explanationRu: json['explanation_ru'],
      questionEn: json['question_en'],
      questionRu: json['question_ru'],
    );
  }

  static List<Question> fromJsonArray(List<dynamic> jsonArray) {
    List<Question> questionsFromJson = [];

    for (var jsonData in jsonArray) {
      questionsFromJson.add(Question.fromJson(jsonData));
    }

    return questionsFromJson;
  }

  // List<String> _convertVaccinations(List<dynamic> vaccinationMap) {
  //   final vaccinations = <String>[];
  //
  //   for (final vaccination in vaccinationMap) {
  //     vaccinations.add(Vaccination.fromJson(vaccination as Map<String, dynamic>));
  //   }
  //   return vaccinations;
  // }

}
