import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

class PastTriviaContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (context, _ViewModel viewModel) =>
          Center(child: Text("")),
    );
  }
}

class _ViewModel {

  _ViewModel();


  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
    );
  }
}
