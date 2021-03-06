import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

class LoadingApp extends StatelessWidget {
  final ViewModelBuilder<bool> builder;

  const LoadingApp(this.builder, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      distinct: true,
      converter: (Store<AppState> store) => store.state.loadingState.isLoadingApp,
      builder: builder,
    );
  }
}