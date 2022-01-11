class Record {
  final int percentCorrect;
  final String date;
  final String name;
  final String uid;

  Record(
      {required this.percentCorrect,
      required this.date,
      required this.name,
      required this.uid});

  Record.fromJson(Map<String, Object?> json)
      : this(
          percentCorrect: json['percent']! as int,
          date: json['date']! as String,
          name: json['name']! as String,
          uid: json['uid']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'percent': percentCorrect,
      'date': date,
      'name': name,
      'uid': uid,
    };
  }
}
