import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/constants_map.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/past_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';
import 'package:weekly_bible_trivia/widgets/dialogs.dart';
import 'package:weekly_bible_trivia/widgets/grids_view.dart';

class PastTriviaContainer extends StatefulWidget {
  @override
  _PastTriviaContainerState createState() => _PastTriviaContainerState();
}

class _PastTriviaContainerState extends State<PastTriviaContainer> {
  late bool _isPortrait;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          _isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;
          return SizedBox.expand(
            child: Container(
                color: Color(viewModel.primaryColor),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Stack(children: [
                    Container(
                      padding: EdgeInsets.only(top: 100, left: 10, right: 10),
                      child: viewModel.listPastBookNames.isEmpty ? null : pastTriviaSelectBookGridView(
                        listImages: viewModel.listPastBookNames
                            .map((book) => mapImages[book] ?? '')
                            .toList(),
                        listDisplayBooks: selectListDisplayBooks(
                            true, viewModel.language == ENGLISH),
                        listBooks: viewModel.listPastBookNames,
                        isPortrait: _isPortrait,
                        callback: (String bookName) {
                          viewModel.setBookAndOpenDialog(bookName);
                        },
                        primaryColor: Color(viewModel.primaryColor),
                        shadowColor: Color(viewModel.shadowColor),
                        textColor: Color(viewModel.textColor),
                      ),
                    ),
                    Visibility(
                      visible: viewModel.isShowDialog,
                      child: pastTriviaDialog(
                          bookName: viewModel.selectedBook,
                          selectedChapter: viewModel.selectedChapter,
                          displayBookName: viewModel.language == RUSSIAN
                              ? mapBooksRu[viewModel.selectedBook]
                              : viewModel.selectedBook,
                          countChapters: viewModel
                              .mapCountPastChapters[viewModel.selectedBook],
                          callback: (int chapter) {
                            viewModel.setChapter(chapter);
                          },
                          closeCallback: () {
                            viewModel.closeDialog();
                          },
                          confirmCallback: () {
                            viewModel.closeDialogeAndNavigateToTrivia();
                          },
                          isPortrait: _isPortrait,
                          backgroundColor: Color(viewModel.primaryColor),
                          sellColor: Color(viewModel.secondaryColor),
                          selectedCellColor: Color(viewModel.shadowColor),
                          textColor: Color(viewModel.textColor)),
                    ),
                  ]),
                )),
          );
        });
  }
}

class _ViewModel {
  final int primaryColor;
  final int secondaryColor;
  final int shadowColor;
  final int textColor;
  final String language;
  final String selectedBook;
  final int selectedChapter;
  final bool isShowDialog;
  final List<String> listPastBookNames;
  final Map<String, int> mapCountPastChapters;

  final Function(String) setBookAndOpenDialog;
  final Function(int) setChapter;
  final Function() closeDialogeAndNavigateToTrivia;
  final Function() closeDialog;

  _ViewModel({
    required this.primaryColor,
    required this.secondaryColor,
    required this.shadowColor,
    required this.textColor,
    required this.language,
    required this.selectedBook,
    required this.selectedChapter,
    required this.isShowDialog,
    required this.setBookAndOpenDialog,
    required this.setChapter,
    required this.closeDialogeAndNavigateToTrivia,
    required this.closeDialog,
    required this.listPastBookNames,
    required this.mapCountPastChapters,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
        primaryColor: store.state.themeSettingsState.primaryColor,
        secondaryColor: store.state.themeSettingsState.secondaryColor,
        shadowColor: store.state.themeSettingsState.shadowColor,
        textColor: store.state.themeSettingsState.textColor,
        language: store.state.localStorageState.language,
        selectedBook: store.state.pastTriviaState.bookName,
        selectedChapter: store.state.pastTriviaState.chapter,
        isShowDialog: store.state.pastTriviaState.isShowDialog,
        listPastBookNames: store.state.infoTriviaState.listPastBookNames,
        mapCountPastChapters: store.state.infoTriviaState.mapCountPastChapters,
        setBookAndOpenDialog: (String bookName) {
          store.dispatch(UpdatePastTriviaDialogAction(true));
          store.dispatch(UpdatePastTriviaBookNameAction(bookName));
        },
        setChapter: (int chapter) {
          store.dispatch(UpdatePastTriviaChapterAction(chapter));
        },
        closeDialogeAndNavigateToTrivia: () {
          store.dispatch(UpdateIsTimeTriviaAction(false));
          store.dispatch(UpdatePastTriviaDialogAction(false));
          store.dispatch(
              updateScreenThunk(NavigateFromHomeToTriviaScreenAction()));
        },
        closeDialog: () {
          store.dispatch(ResetPastTriviaAction());
        });
  }
}
