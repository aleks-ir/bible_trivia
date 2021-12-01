
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons/menu_buttons.dart';
import 'package:weekly_bible_trivia/widgets/sliding_appbar.dart';

class HomeMenuBar extends StatelessWidget{
  final String title;
  final AnimationController controller;

  HomeMenuBar(
    this.title,
    this.controller, {
    Key? key,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (context, _ViewModel viewModel) => SlidingAppBar(
        controller: controller,
        visible: viewModel.isMenuBar,
        child: AppBar(
            actions: [
              Expanded(
                child: SizedBox(),
                flex: 2,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                  child: menuMaterialButton("Russian", viewModel.language == Language.russian, () {viewModel.changeLanguage(Language.russian);}),
                ),
                flex: 5,
              ),
              Expanded(
                child: SizedBox(),
                flex: 1,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                  child: menuMaterialButton("English", viewModel.language == Language.english, () {viewModel.changeLanguage(Language.english);}),
                ),
                flex: 5,
              ),
              Expanded(
                child: SizedBox(),
                flex: 2,
              ),
            ],
            shape: ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50.0))),
          backgroundColor: Color(viewModel.appBarColor,)),

      ),
    );
  }
}

class _ViewModel {
  final int appBarColor;
  final bool isMenuBar;
  final Language language;
  final Function(Language value) changeLanguage;

  _ViewModel({
    required this.appBarColor,
    required this.isMenuBar,
    required this.language,
    required this.changeLanguage,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
        appBarColor: store.state.themeSettingsState.appBarColor,
        isMenuBar: store.state.appBarState.isShowMenuBar,
        language: store.state.localStorageState.language,
        changeLanguage: (value) => {
              store.dispatch(saveLanguageThunk(value)),
            });
  }
}
