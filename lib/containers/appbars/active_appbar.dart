
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/containers/appbars/past_trivia_appbar.dart';
import 'package:weekly_bible_trivia/containers/appbars/reader_appbar.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import '../../global/translation_i18n.dart';
import 'home_appbar.dart';

class ActiveAppBar extends StatelessWidget with PreferredSizeWidget {

  final AnimationController controller;

  @override
  final Size preferredSize;

  ActiveAppBar(
      this.controller,
     {
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          switch (viewModel.activeTab) {
            case NavigationTab.home:
              return HomeAppBar("WT Bible");
            case NavigationTab.reader:
              return ReaderAppBar(controller);
            case NavigationTab.pastTrivia:
              return PastTriviaAppBar(trivia.i18n);
            default:
              return AppBar(title: const Text(""), backgroundColor: Colors.white,);
          }
        });
  }
}

class _ViewModel {
  final NavigationTab activeTab;

  _ViewModel({
    required this.activeTab,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      activeTab: store.state.bottomBarState.activeTab,
    );
  }

}
