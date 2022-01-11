import 'package:meta/meta.dart';

@immutable
class InfoState {
  final String nextBookName;
  final String nextChapters;
  final DateTime nextDate;
  final DateTime currentDate;
  final List<String> listPastBookNames;
  final Map<String, int> mapCountPastChapters;

  InfoState(
      {required this.nextBookName,
      required this.nextChapters,
      required this.nextDate,
      required this.currentDate,
      required this.listPastBookNames,
      required this.mapCountPastChapters});

  InfoState copyWith({
    String? nextBookName,
    String? nextChapters,
    DateTime? nextDate,
    DateTime? currentDate,
    List<String>? listPastBookNames,
    Map<String, int>? mapCountPastChapters,
  }) {
    return InfoState(
        nextBookName: nextBookName ?? this.nextBookName,
        nextChapters: nextChapters ?? this.nextChapters,
        nextDate: nextDate ?? this.nextDate,
        currentDate: currentDate ?? this.currentDate,
        listPastBookNames: listPastBookNames ?? this.listPastBookNames,
        mapCountPastChapters: mapCountPastChapters ?? this.mapCountPastChapters);
  }

  factory InfoState.initial() {
    return InfoState(
      nextBookName: "",
      nextChapters: "",
      nextDate: DateTime(2000, 1, 1),
      currentDate: DateTime(2000, 1, 1),
      listPastBookNames: [],
      mapCountPastChapters: {},
    );
  }
}
