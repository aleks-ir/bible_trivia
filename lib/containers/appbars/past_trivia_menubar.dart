import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/past_trivia_action.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';
import 'package:weekly_bible_trivia/widgets/sliding_menubar.dart';

class PastTriviaMenuBar extends StatelessWidget {
  final String title;
  final AnimationController controller;

  PastTriviaMenuBar(
    this.title,
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      "Item 1",
      "Item 2",
      "Item 3",
      "Item 4",
    ];
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (context, _ViewModel viewModel) => SlidingMenuBar(
        controller: controller,
        visible: viewModel.isShowMenuBar,
        child: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          color: Color(viewModel.appBarColor),
                          child: Center(
                              child: menuMaterialButton(viewModel.books[index],
                                  viewModel.activeBook == index, () {
                            viewModel.changeActiveBook(index);
                          }, radiusCircular: 10, activeColor: Color(viewModel.iconColor))),
                        );
                      }),
                ),
              ),
              Expanded(flex: 1, child: SizedBox()),
            ],
            shape: ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50.0))),
            backgroundColor: Color(
              viewModel.appBarColor,
            )),
      ),
    );
  }
}

class _ViewModel {
  final int iconColor;
  final int appBarColor;
  final bool isShowMenuBar;
  final int activeBook;
  final List<String> books;
  final Function(int value) changeActiveBook;

  _ViewModel({
    required this.iconColor,
    required this.appBarColor,
    required this.isShowMenuBar,
    required this.activeBook,
    required this.books,
    required this.changeActiveBook,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
        iconColor: store.state.themeSettingsState.iconColor,
        appBarColor: store.state.themeSettingsState.appBarColor,
        isShowMenuBar: store.state.appBarState.isShowMenuBar,
        activeBook: store.state.pastTriviaState.selectedBook,
        books: store.state.pastTriviaState.books,
        changeActiveBook: (value) => {
              store.dispatch(SelectBookAction(value)),
            });
  }
}
