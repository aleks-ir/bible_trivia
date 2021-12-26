import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/text_styles.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

class PastTriviaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  @override
  final Size preferredSize;

  PastTriviaAppBar(
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
              // Leave it alone
              // actions: [
              //   IconButton(
              //     icon: Icon(
              //       Icons.receipt_long,
              //       color: Color(viewModel.iconColor),
              //     ),
              //     onPressed: () {
              //       viewModel.changeShowMenuBar(
              //           viewModel.isShowMenuBar ? false : true);
              //     },
              //   ),
              //   const SizedBox(
              //     width: 10,
              //   ),
              // ],
              centerTitle: true,
              title: Text(
                title,
                style: TextStyles.getAppBarStyle(Color(viewModel.textColor)),
              ),
              backgroundColor: Color(viewModel.appBarColor),
            ));
  }
}

class _ViewModel {
  final int iconColor;
  final int appBarColor;
  final int textColor;
  final bool isShowMenuBar;
  final Function(bool) changeShowMenuBar;

  _ViewModel({
    required this.iconColor,
    required this.appBarColor,
    required this.textColor,
    required this.isShowMenuBar,
    required this.changeShowMenuBar,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      iconColor: store.state.themeSettingsState.iconColor,
      appBarColor: store.state.themeSettingsState.appBarColor,
      textColor: store.state.themeSettingsState.textColor,
      isShowMenuBar: store.state.appBarState.isShowMenuBar,
      changeShowMenuBar: (value) =>
          store.dispatch(UpdateShowMenuBarAction(value)),
    );
  }
}
