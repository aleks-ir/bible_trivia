import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

class TriviaContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          return SizedBox.expand(
            child: Container(
              color: Color(viewModel.primaryColor),
              child: Text(""),
            ),
          );
        });
  }
}

class _ViewModel {
  final int primaryColor;
  final int textColor;

  _ViewModel({
    required this.primaryColor,
    required this.textColor,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      primaryColor: store.state.themeSettingsState.primaryColor,
      textColor: store.state.themeSettingsState.textColor,
    );
  }
}
