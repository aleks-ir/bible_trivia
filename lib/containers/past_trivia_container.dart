import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/constants_map.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/models/firebase/image_book.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/past_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/weekly_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/access_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/firebase_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';
import 'package:weekly_bible_trivia/widgets/blur_background.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';
import 'package:weekly_bible_trivia/widgets/dialogs.dart';
import 'package:weekly_bible_trivia/widgets/grids_view.dart';
import 'package:weekly_bible_trivia/widgets/progress_indicators.dart';
import 'package:weekly_bible_trivia/widgets/snack_bar.dart';

class PastTriviaContainer extends StatelessWidget {
  PastTriviaContainer({Key? key}) : super(key: key);
  Map<String, String> imageUrlMap = {};

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          if (!viewModel.isAccessTrivia && viewModel.message.isNotEmpty) {
            Future.delayed(Duration.zero, () async {
              ScaffoldMessenger.of(context).showSnackBar(floatingSnackBar(
                title: viewModel.message,
                color: Color(viewModel.primaryColor),
                textColor: Color(viewModel.iconColor),
                margin: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
              ));
              viewModel.resetAccessAndMessage();
            });
          }

          return GestureDetector(
            onTap: viewModel.isShowWeeklyTriviaDialog ||
                    viewModel.isShowPastTriviaDialog
                ? () => viewModel.closeTriviaDialog()
                : null,
            child: SizedBox.expand(
              child: Container(
                  color: Color(viewModel.primaryColor),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Stack(alignment: Alignment.center, children: [
                      Container(
                        child: viewModel.listPastBookNames.isEmpty
                            ? null
                            : PastTriviaSelectBookGridView(
                                bookImageUrlMap: viewModel.bookImageUrlMap,
                                displayBookList: selectListDisplayBooks(
                                    true, viewModel.language == ENGLISH),
                                bookList: viewModel.listPastBookNames,
                                callback: (String bookName) {
                                  if (viewModel.isShowPastTriviaDialog) {
                                    viewModel.closeTriviaDialog();
                                  } else {
                                    viewModel.setBookAndOpenPastTriviaDialog(
                                        bookName);
                                  }
                                },
                                primaryColor: Color(viewModel.primaryColor),
                                secondaryColor: Color(viewModel.secondaryColor),
                                shadowColor: Color(viewModel.shadowColor),
                                textColor: Color(viewModel.textColor),
                              ),
                      ),
                      Positioned(
                        top: 70,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/ 3,
                          height: 40,
                          child: Card(
                            color: Color(viewModel.primaryColor),
                            elevation: 2,
                            margin: const EdgeInsets.only(left: 0, right: 0),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: AppTextButton(
                                callback: viewModel.openWeeklyTriviaDialog,
                                title: start.i18n,
                                isLoading: !viewModel.isShowPastTriviaDialog &&
                                    viewModel.isLoadingData,
                                textColor: Color(viewModel.iconColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: viewModel.isShowWeeklyTriviaDialog ||
                              viewModel.isShowPastTriviaDialog,
                          child: const BlurBackground()),

                      Visibility(
                        visible: viewModel.isShowWeeklyTriviaDialog,
                        child: WeeklyTriviaDialog(
                            isLoadingData: viewModel.isLoadingData,
                            infoTriviaBook: viewModel.language == RUSSIAN
                                ? mapBooksRu[viewModel.infoTriviaBook] ?? ''
                                : viewModel.infoTriviaBook,
                            infoTriviaChapters: viewModel.infoTriviaChapters,
                            infoTriviaDate: _getDateString(
                                viewModel.infoTriviaDate, viewModel.language),
                            infoQuestionCount: viewModel.infoQuestionCount,
                            confirmCallback: viewModel.getAccessWeeklyTrivia,
                            infoRuntime: viewModel.infoRuntime,
                            closeCallback: viewModel.closeTriviaDialog,
                            backgroundColor: Color(viewModel.primaryColor),
                            textColor: Color(viewModel.textColor)),
                      ),

                      Visibility(
                        visible: viewModel.isShowPastTriviaDialog,
                        child: PastTriviaDialog(
                            isLoadingData: viewModel.isLoadingData,
                            bookName: viewModel.selectedBook,
                            displayBookName: viewModel.language == RUSSIAN
                                ? mapBooksRu[viewModel.selectedBook] ?? ''
                                : viewModel.selectedBook,
                            selectedChapter: viewModel.selectedChapter,
                            countChapters: viewModel
                                .mapCountPastChapters[viewModel.selectedBook],
                            changeChapterCallback: (int chapter) {
                              viewModel.setChapter(chapter);
                            },
                            confirmCallback:
                                viewModel.getDataAndNavigateToPastTrivia,
                            closeCallback: viewModel.closeTriviaDialog,
                            backgroundColor: Color(viewModel.primaryColor),
                            sellColor: Color(viewModel.secondaryColor),
                            selectedCellColor: Color(viewModel.shadowColor),
                            textColor: Color(viewModel.textColor)),
                      ),
                    ]),
                  )),
            ),
          );
        });
  }

  String _getDateString(DateTime currentDate, String language) {
    final month = selectMapMonths(language)[currentDate.month];
    return '${currentDate.day} $month ${currentDate.year}';
  }
}

class _ViewModel {
  final bool isLoadingData;
  final int primaryColor;
  final int secondaryColor;
  final int shadowColor;
  final int textColor;
  final int iconColor;
  final String language;
  final String selectedBook;
  final int selectedChapter;
  final bool isShowPastTriviaDialog;
  final bool isShowWeeklyTriviaDialog;
  final bool isAccessTrivia;
  final String message;
  final List<String> listPastBookNames;
  final Map<String, String> bookImageUrlMap;
  final Map<String, int> mapCountPastChapters;
  final String infoTriviaBook;
  final String infoTriviaChapters;
  final DateTime infoTriviaDate;
  final String infoQuestionCount;
  final String infoRuntime;

  final Function(String) setBookAndOpenPastTriviaDialog;
  final Function() openWeeklyTriviaDialog;
  final Function(int) setChapter;
  final Function() getDataAndNavigateToPastTrivia;
  final Function() navigateToWeeklyTrivia;
  final Function() closeTriviaDialog;
  final Function() getAccessWeeklyTrivia;
  final Function() resetAccessAndMessage;

  _ViewModel({
    required this.isLoadingData,
    required this.primaryColor,
    required this.secondaryColor,
    required this.shadowColor,
    required this.textColor,
    required this.iconColor,
    required this.language,
    required this.selectedBook,
    required this.selectedChapter,
    required this.isShowPastTriviaDialog,
    required this.isShowWeeklyTriviaDialog,
    required this.isAccessTrivia,
    required this.message,
    required this.listPastBookNames,
    required this.bookImageUrlMap,
    required this.mapCountPastChapters,
    required this.infoTriviaBook,
    required this.infoTriviaChapters,
    required this.infoTriviaDate,
    required this.setBookAndOpenPastTriviaDialog,
    required this.openWeeklyTriviaDialog,
    required this.setChapter,
    required this.getDataAndNavigateToPastTrivia,
    required this.navigateToWeeklyTrivia,
    required this.closeTriviaDialog,
    required this.getAccessWeeklyTrivia,
    required this.resetAccessAndMessage,
    required this.infoQuestionCount,
    required this.infoRuntime,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
        isLoadingData: store.state.loadingState.isLoadingDataFromFirebase,
        primaryColor: store.state.themeSettingsState.primaryColor,
        secondaryColor: store.state.themeSettingsState.secondaryColor,
        shadowColor: store.state.themeSettingsState.shadowColor,
        textColor: store.state.themeSettingsState.textColor,
        iconColor: store.state.themeSettingsState.iconColor,
        language: store.state.localStorageState.language,
        selectedBook: store.state.pastTriviaState.bookName,
        selectedChapter: store.state.pastTriviaState.chapter,
        isShowPastTriviaDialog:
            store.state.pastTriviaState.isShowPastTriviaDialog,
        isShowWeeklyTriviaDialog:
            store.state.pastTriviaState.isShowWeeklyTriviaDialog,
        isAccessTrivia: store.state.weeklyTriviaState.isAccessTrivia,
        message: store.state.weeklyTriviaState.messageError,
        listPastBookNames: store.state.pastTriviaState.listPastBookNames,
        bookImageUrlMap: store.state.pastTriviaState.bookImageUrlMap,
        mapCountPastChapters: store.state.pastTriviaState.mapCountPastChapters,
        infoTriviaBook: store.state.infoTriviaState.nextBookName,
        infoTriviaDate: store.state.infoTriviaState.nextDate,
        infoTriviaChapters: store.state.infoTriviaState.nextChapters,
        infoQuestionCount:
            store.state.weeklyTriviaState.questions.length.toString(),
        infoRuntime: store.state.weeklyTriviaState.runtime.toString(),
        setBookAndOpenPastTriviaDialog: (String bookName) {
          store.dispatch(UpdatePastTriviaDialogAction(true));
          store.dispatch(UpdatePastTriviaBookNameAction(bookName));
        },
        openWeeklyTriviaDialog: () {
          store.dispatch(UpdateWeeklyTriviaDialogAction(true));
        },
        setChapter: (int chapter) {
          store.dispatch(UpdatePastTriviaChapterAction(chapter));
        },
        getDataAndNavigateToPastTrivia: () {
          store.dispatch(UpdateIsTimeTriviaAction(false));
          store.dispatch(getDataPastTriviaFromFirebaseAndNavigateThunk());
        },
        navigateToWeeklyTrivia: () {
          store.dispatch(UpdateIsTimeTriviaAction(true));
          store.dispatch(UpdateTriviaQuestionsAction(
              store.state.weeklyTriviaState.questions));
          store.dispatch(
              updateScreenThunk(NavigateFromHomeToTriviaScreenAction()));
        },
        getAccessWeeklyTrivia: () {
          store.dispatch(getAccessWeeklyTriviaThunk());
        },
        closeTriviaDialog: () {
          store.dispatch(ResetTriviaDialogAction());
        },
        resetAccessAndMessage: () {
          store.dispatch(UpdateAccessWeeklyTriviaAction(false));
          store.dispatch(AccessWeeklyTriviaErrorAction(''));
        });
  }
}
