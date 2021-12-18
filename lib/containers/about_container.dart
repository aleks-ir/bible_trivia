import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

class AboutContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          return SizedBox.expand(
            child: Container(
              color: Color(viewModel.primaryColor),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('assets/images/bible.jpg'),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, top: 30),
                      child: Center(child: Text("WT Bible", style: TextStyle(fontSize: 20, color: Color(viewModel.textColor)),), ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: Text(infoAbout.i18n, style: TextStyle(fontSize: 20, color: Color(viewModel.textColor)),),
                    ),
                  ],
                ),
              ),
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
