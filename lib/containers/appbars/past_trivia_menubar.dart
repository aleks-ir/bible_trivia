import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/sliding_menubar.dart';

class PastTriviaMenuBar extends StatelessWidget {
  final String title;
  final AnimationController controller;

  PastTriviaMenuBar(
    this.title,
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (context, _ViewModel viewModel) => SlidingMenuBar(
        controller: controller,
        visible: viewModel.isShowMenuBar,
        child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              padding: EdgeInsets.only(top: 100),
              height: 150,
              child: Row(
                children: [
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 20,
                    child: Container(),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                ],
              ),
            ),
            shape: ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50.0))),
            backgroundColor: Color(
              viewModel.appBarColor,
            )),
      ),
    );
  }
}

class _ViewModel {
  final int iconColor;
  final int appBarColor;
  final bool isShowMenuBar;

  _ViewModel({
    required this.iconColor,
    required this.appBarColor,
    required this.isShowMenuBar,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
        iconColor: store.state.themeSettingsState.iconColor,
        appBarColor: store.state.themeSettingsState.appBarColor,
        isShowMenuBar: store.state.appBarState.isShowMenuBar,
    );
  }
}
