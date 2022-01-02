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

  ReaderMenuBar(
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
            padding: EdgeInsets.only(top: 95),
            height: 135,
            child: Row(children: [const Expanded(flex: 2, child: SizedBox()),
              Expanded(
                  flex: 5,
                  child: menuFloatingButton(
                      Icon(Icons.dark_mode), viewModel.theme == DARK, () {
                    viewModel.changeTheme(DARK);
                    viewModel.changeThemeSettings(selectTheme(DARK));
                  }, activeColor: Color(viewModel.iconColor))),
              Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.brightness_4,
                    color:
                    viewModel.theme == DARK ? Colors.white : Colors.black54,
                  )),
              Expanded(
                  flex: 5,
                  child: menuFloatingButton(
                      Icon(Icons.light_mode), viewModel.theme == LIGHT, () {
                    viewModel.changeTheme(LIGHT);
                    viewModel.changeThemeSettings(selectTheme(LIGHT));
                  }, activeColor: Color(viewModel.iconColor))),

              const Expanded(flex: 3, child: SizedBox()),
              Expanded(
                  flex: 5,
                  child: menuFloatingButton(const Icon(Icons.remove), false, () {
                    viewModel.changeFontSize(viewModel.fontSize - 2);
                  }, activeColor: Color(viewModel.iconColor))),
              Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.format_size,
                    color:
                    viewModel.theme == DARK ? Colors.white : Colors.black54,
                  )),
              Expanded(
                  flex: 5,
                  child: menuFloatingButton(Icon(Icons.add), false, () {
                    viewModel.changeFontSize(viewModel.fontSize + 2);
                  }, activeColor: Color(viewModel.iconColor))),
              //const Expanded(flex:1, child: SizedBox()),
              const Expanded(flex: 2, child: SizedBox())],),
          ),
          shape: ContinuousRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(50.0))),
          backgroundColor: Color(
            viewModel.appBarColor,
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final int iconColor;
  final int appBarColor;
  final int shadowColor;
  final bool isMenuBar;
  final String theme;
  final double fontSize;
  final Function(String) changeTheme;
  final Function(AppTheme) changeThemeSettings;
  final Function(double) changeFontSize;

  _ViewModel({
    required this.iconColor,
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
        iconColor: store.state.themeSettingsState.iconColor,
        appBarColor: store.state.themeSettingsState.appBarColor,
        shadowColor: store.state.themeSettingsState.shadowColor,
        isMenuBar: store.state.appBarState.isShowMenuBar,
        theme: store.state.localStorageState.theme,
        fontSize: store.state.localStorageState.fontSize,
        changeTheme: (value) => {
              store.dispatch(saveThemeThunk(value)),
            },
        changeFontSize: (value) => {
              store.dispatch(saveFontSizeThunk(value)),
            },
        changeThemeSettings: (theme) => {
              store.dispatch(UpdateThemeSettingsAction(
                  theme.primaryColor,
                  theme.secondaryColor,
                  theme.appBarColor,
                  theme.shadowColor,
                  theme.textColor,
                  theme.iconColor)),
            });
  }
}
