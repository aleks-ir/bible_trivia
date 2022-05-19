import 'package:flutter/material.dart';

@immutable
class PastTriviaState {
  final String bookName;
  final int chapter;
  final bool isShowPastTriviaDialog;
  final bool isShowWeeklyTriviaDialog;
  final Map<String, String> bookImageUrlMap;
  final List<String> listPastBookNames;
  final Map<String, int> mapCountPastChapters;

  const PastTriviaState(
      {required this.bookName,
      required this.chapter,
      required this.isShowPastTriviaDialog,
        required this.isShowWeeklyTriviaDialog,
      required this.bookImageUrlMap,
      required this.listPastBookNames,
      required this.mapCountPastChapters});

  PastTriviaState copyWith({
    String? bookName,
    int? chapter,
    bool? isShowPastTriviaDialog,
    bool? isShowWeeklyTriviaDialog,
    bool? isShowDate,
    bool? isShowTopic,
    Map<String, String>? bookImageUrlMap,
    List<String>? listPastBookNames,
    Map<String, int>? mapCountPastChapters,
  }) {
    return PastTriviaState(
        bookName: bookName ?? this.bookName,
        chapter: chapter ?? this.chapter,
        isShowPastTriviaDialog: isShowPastTriviaDialog ?? this.isShowPastTriviaDialog,
        isShowWeeklyTriviaDialog: isShowWeeklyTriviaDialog ?? this.isShowWeeklyTriviaDialog,
        bookImageUrlMap: bookImageUrlMap ?? this.bookImageUrlMap,
        listPastBookNames: listPastBookNames ?? this.listPastBookNames,
        mapCountPastChapters:
            mapCountPastChapters ?? this.mapCountPastChapters);
  }

  factory PastTriviaState.initial() {
    return const PastTriviaState(
      bookName: "",
      chapter: -1,
      isShowPastTriviaDialog: false,
      isShowWeeklyTriviaDialog: false,
      bookImageUrlMap: {},
      listPastBookNames: [],
      mapCountPastChapters: {},
    );
  }
}
