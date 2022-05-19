import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/text_styles.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

class SimpleAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final dynamic actionNavigateRoute;
  

  @override
  final Size preferredSize;

  SimpleAppBar(
    this.title,
    this.actionNavigateRoute, {
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          return AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Icon(Icons.chevron_right,
                        size: 20,
                        color: Color(viewModel.iconColor)),
                  ),
                  splashRadius: 20,
                  onPressed: () => viewModel.navigateTo(actionNavigateRoute),
              ),
            ],
            title: Text(title, style: TextStyles.getAppBarStyle(Color(viewModel.textColor))),
            backgroundColor: Color(viewModel.appBarColor),
          );
        });
  }
}

class _ViewModel {
  final int iconColor;
  final int appBarColor;
  final int textColor;
  final Function(dynamic) navigateTo;

  _ViewModel({
    required this.iconColor,
    required this.appBarColor,
    required this.textColor,
    required this.navigateTo,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      iconColor: store.state.themeSettingsState.iconColor,
      appBarColor: store.state.themeSettingsState.appBarColor,
      textColor: store.state.themeSettingsState.textColor,
      navigateTo: (actionRoute) => store.dispatch(updateScreenThunk(actionRoute)),
    );
  }
}
