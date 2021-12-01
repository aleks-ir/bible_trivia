import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

class ReaderContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (context, _ViewModel viewModel) {
        return
          SizedBox.expand(
            child: Container(color: Color(viewModel.primaryColor),
                child: SingleChildScrollView(child: Text(viewModel.title,
                  style: TextStyle(fontSize: viewModel.fontSize, color: Color(viewModel.textColor)),))),
          );
      });
  }
}

class _ViewModel {
  final int primaryColor;
  final int textColor;
  final String title;
  final double fontSize;

  _ViewModel({
    required this.primaryColor,
    required this.textColor,
    required this.title,
    required this.fontSize,
  });


  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      primaryColor: store.state.themeSettingsState.primaryColor,
        textColor: store.state.themeSettingsState.textColor,
        title: store.state.readerState.title,
        fontSize: store.state.localStorageState.fontSize,
    );
  }
}
