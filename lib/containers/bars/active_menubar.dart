
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/containers/bars/past_trivia_menubar.dart';
import 'package:weekly_bible_trivia/containers/bars/reader_menubar.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import 'home_menubar.dart';

class ActiveMenuBar extends StatelessWidget with PreferredSizeWidget {
  final AnimationController controller;
  @override
  Size get preferredSize => const Size.fromHeight(80);

  ActiveMenuBar(this.controller, {
    Key? key,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          switch (viewModel.activeTab) {
            case MenuBar.home:
              return HomeMenuBar("Home", controller);
            case MenuBar.reader:
              return ReaderMenuBar("Bible", controller);
            case MenuBar.pastTrivia:
              return PastTriviaMenuBar("Trivia", controller);
            default:
              return AppBar(title: const Text(""), backgroundColor: Colors.white,);
          }
        });
  }

}

class _ViewModel {
  final MenuBar activeTab;

  _ViewModel({
    required this.activeTab,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      activeTab: store.state.appBarState.menuBar,
    );
  }

}
