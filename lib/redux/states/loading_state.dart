import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class LoadingState {
  final bool isLoadingApp;
  final bool isLoadingDataFromApi;

  const LoadingState(
      {required this.isLoadingApp,
      required this.isLoadingDataFromApi});

  LoadingState copyWith({bool? isLoadingApp, bool? isLoadingDataFromApi}) {
    return LoadingState(
      isLoadingApp: isLoadingApp ?? this.isLoadingApp,
      isLoadingDataFromApi: isLoadingDataFromApi ?? this.isLoadingDataFromApi,
    );
  }

  factory LoadingState.initial() {
    return LoadingState(
        isLoadingApp: true,
        isLoadingDataFromApi: false);
  }
}
