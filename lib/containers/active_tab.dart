import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/redux/states/app_tab.dart';

class ActiveTab extends StatelessWidget {
  final ViewModelBuilder<AppTab> builder;

  ActiveTab({required this.builder}) : super();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppTab>(
      distinct: true,
      converter: (Store<AppState> store) => store.state.activeTab,
      builder: builder,
    );
  }
}
