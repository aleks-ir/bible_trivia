
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/constants/enums/themes.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons/menu_buttons.dart';
import 'package:weekly_bible_trivia/widgets/sliding_appbar.dart';

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
      builder: (context, _ViewModel viewModel) => SlidingAppBar(
        controller: controller,
        visible: viewModel.isMenuBar,
        child: AppBar(
          actions: [
            const Expanded(flex: 2, child: SizedBox()),
            //Expanded(flex: 1, child: SizedBox()),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: menuFloatingButton(Icon(Icons.dark_mode),
                      viewModel.theme == Themes.dark, () {viewModel.changeTheme(Themes.dark);}),
                )),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 5),
                  child: Icon(
                    Icons.brightness_4,
                    color: Colors.black54,
                  ),
                )),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: menuFloatingButton(Icon(Icons.light_mode),
                      viewModel.theme == Themes.light, () {viewModel.changeTheme(Themes.light);}),
                )),

            const Expanded(flex: 3, child: SizedBox()),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: menuFloatingButton(const Icon(Icons.remove), false, (){viewModel.changeFontSize(viewModel.fontSize - 2);}),
                )),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 5),
                  child: Icon(
                    Icons.format_size,
                    color: Colors.black54,
                  ),
                )),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: menuFloatingButton(Icon(Icons.add), false, (){viewModel.changeFontSize(viewModel.fontSize + 2);}),
                )),
            //const Expanded(flex:1, child: SizedBox()),
            const Expanded(flex: 2, child: SizedBox()),
          ],
          shape: ContinuousRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(50.0))),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class _ViewModel {
  final bool isMenuBar;
  final Themes theme;
  final double fontSize;
  final Function(Themes value) changeTheme;
  final Function(double value) changeFontSize;

  _ViewModel({
    required this.isMenuBar,
    required this.theme,
    required this.fontSize,
    required this.changeTheme,
    required this.changeFontSize,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
        isMenuBar: store.state.appBarState.isShowMenuBar,
        theme: store.state.localStorageState.theme,
        fontSize: store.state.localStorageState.fontSize,
        changeTheme: (value) => {
              store.dispatch(saveThemeThunk(value)),
            },
        changeFontSize: (value) => {
              store.dispatch(saveFontSizeThunk(value)),
            });
  }
}