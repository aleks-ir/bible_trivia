import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/sliding_menubar.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';

class HomeMenuBar extends StatelessWidget {
  final String title;
  final AnimationController controller;

  HomeMenuBar(
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
                padding: EdgeInsets.only(top: 100),
                height: 155,
                child: Row(children: [
                  Expanded(
                    child: SizedBox(),
                    flex: 4,
                  ),
                  Expanded(
                    child:
                    menuMaterialButton(
                      "🇷🇺 Русский ",
                      viewModel.language == RUSSIAN,
                      () {
                        viewModel.changeLanguage(RUSSIAN);
                        setLocate(context, "ru");
                      },
                    ),
                    flex: 10,
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  Expanded(
                    child: menuMaterialButton(
                      "🇬🇧 English",
                      viewModel.language == ENGLISH,
                      () {
                        viewModel.changeLanguage(ENGLISH);
                        setLocate(context, "en");
                      },
                      activeColor: Color(viewModel.iconColor),
                    ),
                    flex: 10,
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 3,
                  ),
                ])),
            shape: ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50.0))),
            backgroundColor: Color(
              viewModel.appBarColor,
            )),
      ),
    );
  }

  void setLocate(BuildContext context, String locate) {
    I18n.of(context).locale = Locale(locate);
  }
}

class _ViewModel {
  final int iconColor;
  final int appBarColor;
  final int textColor;
  final bool isMenuBar;
  final String language;
  final Function(String) changeLanguage;

  _ViewModel({
    required this.iconColor,
    required this.appBarColor,
    required this.textColor,
    required this.isMenuBar,
    required this.language,
    required this.changeLanguage,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
        iconColor: store.state.themeSettingsState.iconColor,
        appBarColor: store.state.themeSettingsState.appBarColor,
        textColor: store.state.themeSettingsState.textColor,
        isMenuBar: store.state.appBarState.isShowMenuBar,
        language: store.state.localStorageState.language,
        changeLanguage: (value) => {
              store.dispatch(saveLanguageThunk(value)),
              store.dispatch(saveDisplayBookNameThunk(TITLE_BIBLE)),
            });
  }
}
