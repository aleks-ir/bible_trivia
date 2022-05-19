import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/text_styles.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  @override
  final Size preferredSize;

  HomeAppBar(
    this.title, {
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) => AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  splashRadius: 20,
                  icon: Icon(
                    Icons.settings,
                    size: 20,
                    color: Color(viewModel.iconColor),
                  ),
                  onPressed: () {
                    viewModel.changeShowMenuBar(
                        viewModel.isShowMenuBar ? false : true);
                  },
                ),
              ],

              title: Text(title,
                  style: TextStyles.getAppBarStyle(Color(viewModel.textColor))),
              centerTitle: true,
              backgroundColor: Color(viewModel.primaryColor),
            ));
  }
}

class _ViewModel {
  final int iconColor;
  final int primaryColor;
  final int textColor;
  final bool isShowMenuBar;
  final Function(bool) changeShowMenuBar;

  _ViewModel({
    required this.iconColor,
    required this.isShowMenuBar,
    required this.textColor,
    required this.primaryColor,
    required this.changeShowMenuBar,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
        iconColor: store.state.themeSettingsState.iconColor,
        primaryColor: store.state.themeSettingsState.primaryColor,
        textColor: store.state.themeSettingsState.textColor,
        isShowMenuBar: store.state.appBarState.isShowMenuBar,
        changeShowMenuBar: (value) =>
            store.dispatch(UpdateShowMenuBarAction(value)),);
  }
}
