import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class LoadingState {
  final bool isLoadingApp;
  final bool isLoadingDataFromApi;
  final bool isLoadingDataFromFirebase;
  final bool isSearching;

  const LoadingState(
      {required this.isLoadingApp,
      required this.isLoadingDataFromApi,
      required this.isLoadingDataFromFirebase,
      required this.isSearching});

  LoadingState copyWith(
      {bool? isLoadingApp,
      bool? isLoadingDataFromApi,
      bool? isLoadingDataFromFirebase,
      bool? isSearching}) {
    return LoadingState(
      isLoadingApp: isLoadingApp ?? this.isLoadingApp,
      isLoadingDataFromApi: isLoadingDataFromApi ?? this.isLoadingDataFromApi,
      isLoadingDataFromFirebase:
          isLoadingDataFromFirebase ?? this.isLoadingDataFromFirebase,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  factory LoadingState.initial() {
    return const LoadingState(
        isLoadingApp: true,
        isLoadingDataFromApi: false,
        isLoadingDataFromFirebase: false,
        isSearching: false);
  }
}
