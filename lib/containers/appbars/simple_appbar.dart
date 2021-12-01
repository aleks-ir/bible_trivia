import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/text_styles.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/services/navigation_service.dart';
import 'package:weekly_bible_trivia/utils/locator.dart';

class SimpleAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final dynamic actionNavigateRoute;

  final NavigationService _navigationService = locator<NavigationService>();

  @override
  final Size preferredSize;

  SimpleAppBar(
    this.title,
    this.actionNavigateRoute, {
    Key? key,
  })  : preferredSize = Size.fromHeight(50.0),
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
                    child: Icon(Icons.chevron_right, color: Colors.teal),
                  ),
                  onPressed: () => viewModel.make(actionNavigateRoute)),
            ],
            title: Text(this.title, style: TextStyles.getAppBarStyle(Color(viewModel.textColor))),
            backgroundColor: Color(viewModel.appBarColor),
          );
        });
  }
}

class _ViewModel {
  final int appBarColor;
  final int textColor;
  final Function(dynamic) make;

  _ViewModel({
    required this.appBarColor,
    required this.textColor,
    required this.make,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      appBarColor: store.state.themeSettingsState.appBarColor,
      textColor: store.state.themeSettingsState.textColor,
      make: (actionRoute) => store.dispatch(updateScreenThunk(actionRoute)),
    );
  }
}
