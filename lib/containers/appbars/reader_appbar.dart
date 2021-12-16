import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';
import 'package:weekly_bible_trivia/widgets/sliding_appbar.dart';

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
                //const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 3,
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Color(viewModel.iconColor),
                    ),
                    onPressed: () {
                      viewModel.navigateToSearch();
                    },
                  ),
                ),
                const Expanded(flex: 2, child: SizedBox()),
                Expanded(
                    flex: 13,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15.0, 5, 15.0),
                      child: menuOutlinedButton(_getTitle(viewModel.displayBookName, viewModel.chapter.toString()), () {
                        viewModel.navigateToSelection();
                      }, textColor: Color(viewModel.textColor)),
                    )),
                const Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Color(viewModel.iconColor),
                    ),
                    onPressed: () {
                      viewModel.changeShowMenuBar(
                          viewModel.isShowMenuBar ? false : true);
                    },
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
              ],
              backgroundColor: Color(viewModel.appBarColor),
            ),
          );
        });
  }
}

String _getTitle(String displayBookName, String chapter) {
  if(displayBookName == TITLE_BIBLE){
    return bible.i18n;
  }else{
    return displayBookName + " : $chapter";
  }
}

class _ViewModel {
  final int iconColor;
  final int appBarColor;
  final int textColor;
  final String displayBookName;
  final int chapter;
  final bool isShowMenuBar;
  final bool isReaderMod;

  final Function(bool) changeShowMenuBar;
  final Function() navigateToSelection;
  final Function() navigateToSearch;

  _ViewModel({
    required this.iconColor,
    required this.appBarColor,
    required this.textColor,
    required this.displayBookName,
    required this.chapter,
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
      displayBookName: store.state.localStorageState.displayBookName,
      chapter: store.state.localStorageState.chapter,
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
