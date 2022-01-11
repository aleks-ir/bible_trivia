import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/firebase/record.dart';

@immutable
class TableResultsState {
  final List<Record> listRecords;

  const TableResultsState(
      {required this.listRecords,});

  TableResultsState copyWith(
      {List<Record>? listRecords,}) {
    return TableResultsState(
      listRecords: listRecords ?? this.listRecords,
    );
  }

  factory TableResultsState.initial() {
    return const TableResultsState(
      listRecords: [],);
  }
}
