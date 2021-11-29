
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/text_styles.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  @override
  final Size preferredSize;

  HomeAppBar(
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
                IconButton(
                  icon: Transform.scale(
                    scale: 1.0,
                    child: const Icon(
                      Icons.language,
                      color: Colors.black54,
                    ),
                  ),
                  onPressed: () {
                    viewModel.changeShowMenuBar(
                        viewModel.isShowMenuBar ? false : true);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
              title: Text(title, style: TextStyles.appBarStyle),
              centerTitle: true,
              backgroundColor: Colors.white,
            ));
  }
}

class _ViewModel {
  final bool isShowMenuBar;
  final Function(bool) changeShowMenuBar;

  _ViewModel({
    required this.isShowMenuBar,
    required this.changeShowMenuBar,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      isShowMenuBar: store.state.appBarState.isShowMenuBar,
      changeShowMenuBar: (value) => store.dispatch(UpdateShowMenuBarAction(value)),
    );
  }
}
