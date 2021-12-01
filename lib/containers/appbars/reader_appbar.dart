
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/text_styles.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons/menu_buttons.dart';

class ReaderAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  @override
  final Size preferredSize;

  ReaderAppBar(
    this.title, {
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) => AppBar(
              automaticallyImplyLeading: false,
              actions: [
                //const Expanded(flex: 1, child: SizedBox()),
                Expanded(flex: 2,
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.teal,
                    ),
                    onPressed: () {},
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15.0, 5, 15.0),
                      child: menuOutlinedButton("Chapter", (){}, textColor: Color(viewModel.textColor)),
                    )),
                //Expanded(flex: 1, child: SizedBox()),
                Expanded(flex: 8, child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 15.0, 0, 15.0),
                  child: menuOutlinedButton("Translation", (){}, textColor: Color(viewModel.textColor)),
                )),
                const Expanded(flex:1, child: SizedBox()),
                Expanded(flex: 2,
                  child: IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.teal,
                    ),
                    onPressed: () {
                      viewModel.changeShowMenuBar(
                          viewModel.isShowMenuBar ? false : true);
                    },
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
              ],
              title: Text(title, style: TextStyles.getAppBarStyle(Color(viewModel.textColor))),
              backgroundColor: Color(viewModel.appBarColor),
            ));
  }
}

class _ViewModel {
  final int appBarColor;
  final int textColor;
  final bool isShowMenuBar;
  final Function(bool) changeShowMenuBar;

  _ViewModel({
    required this.appBarColor,
    required this.textColor,
    required this.isShowMenuBar,
    required this.changeShowMenuBar,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      appBarColor: store.state.themeSettingsState.appBarColor,
      textColor: store.state.themeSettingsState.textColor,
      isShowMenuBar: store.state.appBarState.isShowMenuBar,
      changeShowMenuBar: (value) => store.dispatch(UpdateShowMenuBarAction(value)),
    );
  }
}
