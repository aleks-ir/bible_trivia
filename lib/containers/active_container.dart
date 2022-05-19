import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/containers/past_trivia_container.dart';
import 'package:weekly_bible_trivia/containers/reader_container.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import 'home_container.dart';

class ActiveContainer extends StatelessWidget {
  const ActiveContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          switch (viewModel.activeTab) {
            case NavigationTab.home:
              return const HomeContainer();
            case NavigationTab.reader:
              return const ReaderContainer();
            case NavigationTab.pastTrivia:
              return PastTriviaContainer();
            default:
              return Container();
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
