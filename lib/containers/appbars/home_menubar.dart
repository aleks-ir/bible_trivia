
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/models/enums.dart';
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
                  child: menuMaterialButton("Russian", viewModel.language == Languages.russian, () {viewModel.changeLanguage(Languages.russian);}),
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
                  child: menuMaterialButton("English", viewModel.language == Languages.english, () {viewModel.changeLanguage(Languages.english);}),
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
          backgroundColor: Colors.white,),

      ),
    );
  }
}

class _ViewModel {
  final bool isMenuBar;
  final Languages language;
  final Function(Languages value) changeLanguage;

  _ViewModel({
    required this.isMenuBar,
    required this.language,
    required this.changeLanguage,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
        isMenuBar: store.state.appBarState.isShowMenuBar,
        language: store.state.localStorageState.language,
        changeLanguage: (value) => {
              store.dispatch(saveLanguageThunk(value)),
            });
  }
}
