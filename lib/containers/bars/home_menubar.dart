import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/sliding_menubar.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';

class HomeMenuBar extends StatelessWidget {
  final String title;
  final AnimationController controller;

  const HomeMenuBar(
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
                    viewModel.changeNotification(true);
                  },
                  child: const Icon(
                    Icons.notifications_active,
                    size: 18,
                  ),
                  isActive: viewModel.isNotification,
                  activeColor: Color(viewModel.iconColor),
                  color: Color(viewModel.secondaryColor),
                  foregroundNoActiveColor: Color(viewModel.iconColor),
                ),
                Icon(
                  Icons.notifications,
                  size: 17,
                  color:
                      viewModel.theme == DARK ? Colors.white : Colors.black54,
                ),
                MenuFloatingButton(
                  callback: () {
                    viewModel.changeNotification(false);
                  },
                  child: const Icon(
                    Icons.notifications_off,
                    size: 18,
                  ),
                  isActive: !viewModel.isNotification,
                  activeColor: Color(viewModel.iconColor),
                  color: Color(viewModel.secondaryColor),
                  foregroundNoActiveColor: Color(viewModel.iconColor),
                ),
                const Spacer(),
                const Spacer(),
                MenuFloatingButton(
                  callback: () {
                    viewModel.changeLanguage(ENGLISH);
                    setLocate(context, "en");
                  },
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(viewModel.language == ENGLISH ? 5 : 8),
                    duration: const Duration(milliseconds: 500),
                    child: Image.asset(UNITED_KINGDOM_IMG),
                  ),
                  isActive: false,
                  activeColor: Color(viewModel.iconColor),
                  color: Color(viewModel.secondaryColor),
                  foregroundNoActiveColor: Color(viewModel.iconColor),
                ),
                Icon(
                  Icons.public,
                  color:
                      viewModel.theme == DARK ? Colors.white : Colors.black54,
                  size: 18,
                ),
                MenuFloatingButton(
                  callback: () {
                    viewModel.changeLanguage(RUSSIAN);
                    setLocate(context, "ru");
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    padding: EdgeInsets.all(viewModel.language == RUSSIAN ? 5 : 8),
                    child: Image.asset(RUSSIA_IMG),
                  ),
                  isActive: false,
                  activeColor: Color(viewModel.iconColor),
                  color: Color(viewModel.secondaryColor),
                  foregroundNoActiveColor: Color(viewModel.iconColor),
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

  void setLocate(BuildContext context, String locate) {
    I18n.of(context).locale = Locale(locate);
  }
}

class _ViewModel {
  final int iconColor;
  final int secondaryColor;
  final int appBarColor;
  final int shadowColor;
  final bool isMenuBar;
  final String theme;
  final bool isNotification;
  final String language;
  final Function(String) changeLanguage;
  final Function(bool) changeNotification;

  _ViewModel({
    required this.iconColor,
    required this.secondaryColor,
    required this.appBarColor,
    required this.shadowColor,
    required this.isMenuBar,
    required this.theme,
    required this.isNotification,
    required this.language,
    required this.changeLanguage,
    required this.changeNotification,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      iconColor: store.state.themeSettingsState.iconColor,
      secondaryColor: store.state.themeSettingsState.secondaryColor,
      appBarColor: store.state.themeSettingsState.appBarColor,
      shadowColor: store.state.themeSettingsState.shadowColor,
      isMenuBar: store.state.appBarState.isShowMenuBar,
      theme: store.state.localStorageState.theme,
      isNotification: store.state.localStorageState.isNotification,
      language: store.state.localStorageState.language,
      changeNotification: (value) => {
        store.dispatch(saveNotificationThunk(value)),
      },
      changeLanguage: (value) => {
        store.dispatch(saveLanguageThunk(value)),
      },
    );
  }
}
