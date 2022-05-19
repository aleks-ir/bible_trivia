import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/models/app_theme.dart';
import 'package:weekly_bible_trivia/redux/actions/theme_settings_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';
import 'package:weekly_bible_trivia/utils/sliding_menubar.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';

class ReaderMenuBar extends StatelessWidget {
  final String title;
  final AnimationController controller;

  const ReaderMenuBar(
    this.title,
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (context, _ViewModel viewModel) => SlidingMenuBar(
        controller: controller,
        visible: viewModel.isMenuBar,
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 90),
            height: 130,
            child: Row(
              children: [
                const Spacer(),
                MenuFloatingButton(
                  callback: () {
                    viewModel.changeTheme(DARK);
                    viewModel.changeThemeSettings(selectTheme(DARK));
                  },
                  child: const Icon(
                    Icons.dark_mode,
                    size: 18,
                  ),
                  isActive: viewModel.theme == DARK,
                  activeColor: Color(viewModel.iconColor),
                  color: Color(viewModel.secondaryColor),
                  foregroundNoActiveColor: Color(viewModel.iconColor),
                ),
                Icon(
                  Icons.brightness_4,
                  size: 18,
                  color: viewModel.foregroundIconColor,
                ),
                MenuFloatingButton(
                  callback: () {
                    viewModel.changeTheme(LIGHT);
                    viewModel.changeThemeSettings(selectTheme(LIGHT));
                  },
                  child: const Icon(
                    Icons.light_mode,
                    size: 18,
                  ),
                  isActive: viewModel.theme == LIGHT,
                  activeColor: Color(viewModel.iconColor),
                  color: Color(viewModel.secondaryColor),
                  foregroundNoActiveColor: Color(viewModel.iconColor),
                ),
                const Spacer(),
                const Spacer(),
                MenuFloatingButton(
                  callback: () {
                    viewModel.changeFontSize(viewModel.fontSize - 1);
                  },
                  child: const Icon(
                    Icons.remove,
                    size: 18,
                  ),
                  activeColor: Color(viewModel.iconColor),
                  color: Color(viewModel.secondaryColor),
                  foregroundNoActiveColor: viewModel.foregroundIconColor,
                ),
                Icon(
                  Icons.format_size,
                  color: viewModel.foregroundIconColor,
                  size: 18,
                ),
                MenuFloatingButton(
                  callback: () {
                    viewModel.changeFontSize(viewModel.fontSize + 1);
                  },
                  child: const Icon(
                    Icons.add,
                    size: 18,
                  ),
                  color: Color(viewModel.secondaryColor),
                  foregroundNoActiveColor: viewModel.foregroundIconColor,
                ),
                const Spacer(),
              ],
            ),
          ),
          shape: const ContinuousRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(25.0))),
          backgroundColor: Color(
            viewModel.appBarColor,
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final Color foregroundIconColor;
  final int iconColor;
  final int secondaryColor;
  final int appBarColor;
  final int shadowColor;
  final bool isMenuBar;
  final String theme;
  final double fontSize;
  final Function(String) changeTheme;
  final Function(AppTheme) changeThemeSettings;
  final Function(double) changeFontSize;

  _ViewModel({
    required this.foregroundIconColor,
    required this.iconColor,
    required this.secondaryColor,
    required this.appBarColor,
    required this.shadowColor,
    required this.isMenuBar,
    required this.theme,
    required this.fontSize,
    required this.changeTheme,
    required this.changeFontSize,
    required this.changeThemeSettings,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
        foregroundIconColor: store.state.localStorageState.theme == DARK
            ? Colors.white
            : Colors.black54,
        iconColor: store.state.themeSettingsState.iconColor,
        secondaryColor: store.state.themeSettingsState.secondaryColor,
        appBarColor: store.state.themeSettingsState.appBarColor,
        shadowColor: store.state.themeSettingsState.shadowColor,
        isMenuBar: store.state.appBarState.isShowMenuBar,
        theme: store.state.localStorageState.theme,
        fontSize: store.state.localStorageState.fontSize,
        changeTheme: (value) => {
              store.dispatch(saveThemeThunk(value)),
            },
        changeFontSize: (value) => {
              if (value >= 5 && value <= 30)
                {
                  store.dispatch(saveFontSizeThunk(value)),
                }
            },
        changeThemeSettings: (theme) => {
              store.dispatch(UpdateThemeSettingsAction(
                  theme.primaryColor,
                  theme.secondaryColor,
                  theme.cardColor,
                  theme.appBarColor,
                  theme.shadowColor,
                  theme.textColor,
                  theme.iconColor)),
            });
  }
}
