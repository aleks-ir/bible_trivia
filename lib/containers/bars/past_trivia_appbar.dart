import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/text_styles.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/access_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/blur_background.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';

class PastTriviaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  @override
  final Size preferredSize;

  const PastTriviaAppBar(
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
              centerTitle: true,
              title: Text(
                title,
                style: TextStyles.getAppBarStyle(Color(viewModel.textColor)),
              ),
              actions: [
                Visibility(
                  visible: viewModel.isAuthenticated,
                  child: IconButton(
                    splashRadius: 20,
                    icon: Icon(
                      Icons.emoji_events,
                      size: 20,
                      color: Color(viewModel.iconColor),
                    ),
                    onPressed: viewModel.navigateToTableResults,
                  ),
                ),
              ],
              backgroundColor: Color(viewModel.appBarColor),
            ));
  }
}

class _ViewModel {
  final bool isLoadingData;
  final int iconColor;
  final int appBarColor;
  final int textColor;
  final bool isShowMenuBar;
  final bool isShowDialog;
  final bool isAuthenticated;
  final Function(bool) changeShowMenuBar;
  final Function() navigateToTableResults;
  final Function() getAccessWeeklyTrivia;

  _ViewModel({
    required this.isLoadingData,
    required this.iconColor,
    required this.appBarColor,
    required this.textColor,
    required this.isShowMenuBar,
    required this.isShowDialog,
    required this.isAuthenticated,
    required this.changeShowMenuBar,
    required this.navigateToTableResults,
    required this.getAccessWeeklyTrivia,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      isLoadingData: store.state.loadingState.isLoadingDataFromFirebase,
      iconColor: store.state.themeSettingsState.iconColor,
      appBarColor: store.state.themeSettingsState.appBarColor,
      textColor: store.state.themeSettingsState.textColor,
      isShowMenuBar: store.state.appBarState.isShowMenuBar,
      isShowDialog: store.state.pastTriviaState.isShowPastTriviaDialog,
      isAuthenticated:
          store.state.authenticationState.status == AuthenticationStatus.loaded,
      changeShowMenuBar: (value) =>
          store.dispatch(UpdateShowMenuBarAction(value)),
      navigateToTableResults: () => store.dispatch(
        updateScreenThunk(NavigateFromHomeToTableResultsScreenAction()),
      ),
      getAccessWeeklyTrivia: () {
        store.dispatch(getAccessWeeklyTriviaThunk());
      },
    );
  }
}
