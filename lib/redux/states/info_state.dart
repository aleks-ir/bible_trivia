import 'package:meta/meta.dart';

@immutable
class InfoState {
  final String nextBookName;
  final String nextChapters;
  final DateTime nextDate;
  final DateTime currentDate;

  const InfoState(
      {required this.nextBookName,
      required this.nextChapters,
      required this.nextDate,
      required this.currentDate,});

  InfoState copyWith({
    String? nextBookName,
    String? nextChapters,
    DateTime? nextDate,
    DateTime? currentDate,
  }) {
    return InfoState(
        nextBookName: nextBookName ?? this.nextBookName,
        nextChapters: nextChapters ?? this.nextChapters,
        nextDate: nextDate ?? this.nextDate,
        currentDate: currentDate ?? this.currentDate,);
  }

  factory InfoState.initial() {
    return InfoState(
      nextBookName: "",
      nextChapters: "",
      nextDate: DateTime(2000, 1, 1),
      currentDate: DateTime(2000, 1, 1),
    );
  }
}
