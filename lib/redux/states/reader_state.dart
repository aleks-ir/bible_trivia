import 'package:flutter/material.dart';

@immutable
class ReaderState {
  final String title;

  const ReaderState({
    required this.title,
  });

  ReaderState copyWith({required String title}) {
    return ReaderState(
      title: this.title,
    );
  }
}
