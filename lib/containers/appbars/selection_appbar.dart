import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

class SelectionAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  SelectionAppBar({
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
              Expanded(
                flex: 3,
                child: TextButton(
                  onPressed: () {
                    viewModel.navigateToTranslation();
                  },
                  child: Text(
                    viewModel.currentTranslation,
                    style: TextStyle(color: Color(viewModel.activeTextColor)),
                  ),
                ),
              ),
              const Expanded(flex: 2, child: SizedBox()),
              Expanded(
                flex: 3,
                child: TextButton(
                    onPressed: () {
                      viewModel.changeTestament(true);
                    },
                    style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: Center(
                      child: Text(
                        oldTestament.i18n,
                        style: TextStyle(
                            color: viewModel.isOldTestament
                                ? Color(viewModel.activeTextColor)
                                : Color(viewModel.noActiveTextColor)),
                      ),
                    )),
              ),
              Expanded(
                flex: 3,
                child: TextButton(
                    onPressed: () {
                      viewModel.changeTestament(false);
                    },
                    style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: Center(
                      child: Text(
                        newTestament.i18n,
                        style: TextStyle(
                            color: viewModel.isOldTestament
                                ? Color(viewModel.noActiveTextColor)
                                : Color(viewModel.activeTextColor)),
                      ),
                    )),
              ),
              const Expanded(flex: 2, child: SizedBox()),
              Expanded(
                flex: 2,
                child: IconButton(
                    icon: Transform.rotate(
                      angle: 90 * pi / 180,
                      child: Icon(Icons.chevron_right, color: Color(viewModel.iconColor)),
                    ),
                    onPressed: () => viewModel.navigateToHome()),
              ),
            ],
            backgroundColor: Color(viewModel.appBarColor),
          );
        });
  }
}

class _ViewModel {
  final int iconColor;
  final int appBarColor;
  final int noActiveTextColor;
  final int activeTextColor;
  final String currentTranslation;
  final bool isOldTestament;

  final Function(bool) changeTestament;
  final Function() navigateToHome;
  final Function() navigateToTranslation;

  _ViewModel({
    required this.iconColor,
    required this.appBarColor,
    required this.noActiveTextColor,
    required this.activeTextColor,
    required this.currentTranslation,
    required this.isOldTestament,
    required this.changeTestament,
    required this.navigateToHome,
    required this.navigateToTranslation,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
        iconColor: store.state.themeSettingsState.iconColor,
        appBarColor: store.state.themeSettingsState.appBarColor,
        noActiveTextColor: store.state.themeSettingsState.shadowColor,
        activeTextColor: store.state.themeSettingsState.textColor,
        currentTranslation: store.state.localStorageState.translationId,
        isOldTestament: store.state.appBarState.isOldTestament,
        changeTestament: (value) =>
            store.dispatch(UpdateTestamentAction(value)),
        navigateToHome: () => store.dispatch(
            updateScreenThunk(NavigateFromSelectionToHomeScreenAction())),
        navigateToTranslation: () => store.dispatch(updateScreenThunk(
            NavigateFromSelectionToTranslationScreenAction())));
  }
}
