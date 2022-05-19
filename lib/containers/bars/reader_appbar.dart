import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/constants_map.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/sliding_appbar.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';

class ReaderAppBar extends StatelessWidget with PreferredSizeWidget {
  final AnimationController controller;

  @override
  final Size preferredSize;

  ReaderAppBar(
    this.controller, {
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          return SlidingAppBar(
            controller: controller,
            visible: !viewModel.isReaderMod,
            child: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  splashRadius: 20,
                  icon: Icon(
                    Icons.search,
                    size: 20,
                    color: Color(viewModel.iconColor),
                  ),
                  onPressed: () {
                    viewModel.navigateToSearch();
                  },
                ),
                const Spacer(),
                Center(
                  child: GestureDetector(
                    onTap: viewModel.navigateToSelection,
                    child: Text(
                      _getTitle(
                          viewModel.language == RUSSIAN
                              ? mapBooksRu[viewModel.bookName]
                              : viewModel.bookName,
                          viewModel.chapter.toString()),
                      style:  TextStyle(
                          fontSize: 12,
                          fontFamily: OPEN_SANS,
                          color: Color(viewModel.textColor)),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  splashRadius: 20,
                  icon: Icon(
                    Icons.settings_suggest,
                    size: 20,
                    color: Color(viewModel.iconColor),
                  ),
                  onPressed: () {
                    viewModel.changeShowMenuBar(
                        viewModel.isShowMenuBar ? false : true);
                  },
                ),
              ],
              backgroundColor: Color(viewModel.appBarColor),
            ),
          );
        });
  }
}

String _getTitle(String? bookName, String chapter) {
  if (bookName == null) {
    return bible.i18n;
  } else {
    return bookName + " : $chapter";
  }
}

class _ViewModel {
  final int iconColor;
  final int appBarColor;
  final int textColor;
  final String bookName;
  final int chapter;
  final String language;
  final bool isShowMenuBar;
  final bool isReaderMod;

  final Function(bool) changeShowMenuBar;
  final Function() navigateToSelection;
  final Function() navigateToSearch;

  _ViewModel({
    required this.iconColor,
    required this.appBarColor,
    required this.textColor,
    required this.bookName,
    required this.chapter,
    required this.language,
    required this.isShowMenuBar,
    required this.isReaderMod,
    required this.changeShowMenuBar,
    required this.navigateToSelection,
    required this.navigateToSearch,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      iconColor: store.state.themeSettingsState.iconColor,
      appBarColor: store.state.themeSettingsState.appBarColor,
      textColor: store.state.themeSettingsState.textColor,
      bookName: store.state.localStorageState.bookName,
      chapter: store.state.localStorageState.chapter,
      language: store.state.localStorageState.language,
      isShowMenuBar: store.state.appBarState.isShowMenuBar,
      isReaderMod: store.state.appBarState.isReaderMod,
      changeShowMenuBar: (value) =>
          store.dispatch(UpdateShowMenuBarAction(value)),
      navigateToSelection: () => store.dispatch(
          updateScreenThunk(NavigateFromHomeToSelectionScreenAction())),
      navigateToSearch: () => store
          .dispatch(updateScreenThunk(NavigateFromHomeToSearchScreenAction())),
    );
  }
}
