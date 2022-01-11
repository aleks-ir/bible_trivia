import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/models/answer.dart';
import 'package:weekly_bible_trivia/models/firebase/question.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/dialogs.dart';
import 'package:weekly_bible_trivia/widgets/slide_items/slide_item.dart';
import 'package:weekly_bible_trivia/widgets/timer.dart';
import 'package:weekly_bible_trivia/widgets/trivia_bars.dart';

class TriviaContainer extends StatefulWidget {
  const TriviaContainer({Key? key}) : super(key: key);

  @override
  _TriviaContainerState createState() {
    return _TriviaContainerState();
  }
}

class _TriviaContainerState extends State<TriviaContainer>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);

  late AnimationController _timerController;

  List<List<Answer>> _initListCurrentAnswers(
      List<Question> questions, String language) {
    return List.generate(
        questions.length,
        (questionIndex) => List.generate(
            questions[questionIndex].answersEn.length,
            (answerIndex) => Answer(
                title: language == RUSSIAN
                    ? questions[questionIndex].answersRu[answerIndex]
                    : questions[questionIndex].answersEn[answerIndex],
                answerId: answerIndex)));
  }

  List<bool> _initListAnsweredQuestions(int countQuestion) {
    return List.filled(countQuestion, false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  void _initDataTrivia(Store<AppState> store) {
    store.dispatch(UpdateListCurrentAnswersAction(_initListCurrentAnswers(
        store.state.triviaState.listQuestions,
        store.state.localStorageState.language)));
    store.dispatch(UpdateListAnsweredQuestionsAction(_initListAnsweredQuestions(
        store.state.triviaState.listQuestions.length)));
    store.dispatch(UpdateTriviaDialogAction(false));
    store.dispatch(UpdateCurrentPageAction(0));
    store.dispatch(UpdateStartPageAction(0));
    store.dispatch(UpdateEndPageAction(10));
  }

  void _initTimeTrivia(Store<AppState> store) {
    _timerController
        .reverse(
            from: _timerController.value == 0.0 ? 1.0 : _timerController.value)
        .whenComplete(() => store.dispatch(
            updateScreenThunk(NavigateFromTriviaToResultScreenAction())));
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return StoreConnector<AppState, _ViewModel>(
        onInit: (Store<AppState> store) {
          _timerController = AnimationController(
            vsync: this,
            duration: Duration(seconds: store.state.weeklyTriviaState.runtime),
          );
          _initDataTrivia(store);
          if (store.state.triviaState.isTimeTrivia) {
            _initTimeTrivia(store);
          }

        },
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          return SizedBox.expand(
            child: Container(
              color: Color(viewModel.primaryColor),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: viewModel.changePage,
                      itemCount: viewModel.questions.length,
                      itemBuilder: (ctx, i) => SlideItem(
                        questionId: i,
                        questionTitle: viewModel.language == RUSSIAN
                            ? viewModel.questions[i].questionRu
                            : viewModel.questions[i].questionEn,
                        currentAnswers: viewModel.currentAnswers[i],
                        isCheckBox:
                            viewModel.questions[i].correctAnswers.length == 1
                                ? false
                                : true,
                        callback: (value, questionId, answerId) {
                          viewModel.changeAnswer(value, questionId, answerId);
                          _updateScreen(viewModel);
                        },
                        color: Color(viewModel.primaryColor),
                        cardColor: Color(viewModel.cardColor),
                        textColor: Color(viewModel.textColor),
                        selectedColor: Color(viewModel.iconColor),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: <Widget>[
                      Visibility(
                        visible: viewModel.isTimeTrivia,
                        child: TimerWidget(
                          timerController: _timerController,
                          indicatorColor: Color(viewModel.iconColor),
                          textColor: Color(viewModel.textColor),
                        ),
                      ),
                      triviaTopBar(
                          titleRightButton: _checkForLastQuestion(viewModel)
                              ? complete.i18n
                              : next.i18n,
                          titleLeftButton: exit.i18n,
                          callbackLeftButton: () {
                            _openOrCloseDialog(viewModel);
                          },
                          callbackRightButton: () {
                            _nextPage(viewModel);
                            _closeDialog(viewModel);
                            if (_checkForLastQuestion(viewModel)) {
                              viewModel.navigateToResult();
                            }
                          },
                          timerController: _timerController,
                          cardColor: Color(viewModel.cardColor),
                          titleColor: Color(viewModel.iconColor)),
                      Card(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(bottom: 20.0),
                          height: 20,
                          child: null,
                        ),
                      ),
                      triviaBottomBar(
                        currentPage: viewModel.currentPage,
                        endPage: viewModel.endPage,
                        startPage: viewModel.startPage,
                        answeredQuestions: viewModel.answeredQuestions,
                        callback: (pageId) {
                          viewModel.changePage(pageId);
                          _pageController.jumpToPage(pageId);
                          _closeDialog(viewModel);
                        },
                        backgroundColor: Color(viewModel.cardColor),
                        answeredColor: Color(viewModel.iconColor),
                        unansweredColor: Color(viewModel.textColor),
                      ),
                      Visibility(
                          visible: viewModel.isShowDialog,
                          child: triviaDialog(
                              closeCallback: () {
                                _closeDialog(viewModel);
                              },
                              confirmCallback: () {
                                _exitTrivia(viewModel);
                              },
                              isDarkTheme:
                                  viewModel.theme == DARK ? true : false,
                              backgroundColor: Color(viewModel.primaryColor),
                              isPortrait: isPortrait,
                              textColor: Color(viewModel.textColor))),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }


  void _updateScreen(_ViewModel viewModel) {
    _pageController.jumpToPage(viewModel.currentPage == viewModel.startPage
        ? viewModel.currentPage + 1
        : viewModel.currentPage - 1);
    _pageController.jumpToPage(viewModel.currentPage);
  }

  void _openOrCloseDialog(_ViewModel viewModel) {
    viewModel.changeIsShowDialog(viewModel.isShowDialog ? false : true);
  }

  void _closeDialog(_ViewModel viewModel) {
    viewModel.changeIsShowDialog(false);
  }

  void _exitTrivia(_ViewModel viewModel) {
    if (viewModel.isTimeTrivia) {
      viewModel.navigateToResult();
    } else {
      viewModel.navigateToHome();
    }
  }

  void _nextPage(_ViewModel viewModel) {
    if (viewModel.currentPage <= viewModel.questions.length - 2) {
      viewModel.changePage(viewModel.currentPage + 1);
      _pageController.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
    } else {
      viewModel.changePage(0);
      _pageController.animateToPage(0,
          duration: const Duration(milliseconds: 1000), curve: Curves.decelerate);
    }
  }

  bool _checkForLastQuestion(_ViewModel viewModel) {
    if (viewModel.answeredQuestions
        .where((element) => element == false)
        .isEmpty) {
      return true;
    }
    return false;
  }
}

class _ViewModel {
  final bool isShowDialog;
  final bool isTimeTrivia;
  final int primaryColor;
  final int cardColor;
  final int textColor;
  final int iconColor;
  final String theme;
  final int currentPage;
  final int startPage;
  final int endPage;
  final String language;
  final List<List<Answer>> currentAnswers;
  final List<Question> questions;
  final List<bool> answeredQuestions;

  final Function() navigateToHome;
  final Function() navigateToResult;
  final Function(bool) changeIsShowDialog;
  final Function(int) changePage;
  final Function(bool?, int, int) changeAnswer;

  _ViewModel({
    required this.isShowDialog,
    required this.isTimeTrivia,
    required this.primaryColor,
    required this.cardColor,
    required this.textColor,
    required this.iconColor,
    required this.theme,
    required this.currentPage,
    required this.startPage,
    required this.endPage,
    required this.language,
    required this.currentAnswers,
    required this.questions,
    required this.answeredQuestions,
    required this.navigateToHome,
    required this.navigateToResult,
    required this.changeIsShowDialog,
    required this.changePage,
    required this.changeAnswer,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      isShowDialog: store.state.triviaState.isShowDialog,
      isTimeTrivia: store.state.triviaState.isTimeTrivia,
      primaryColor: store.state.themeSettingsState.primaryColor,
      cardColor: store.state.themeSettingsState.cardColor,
      textColor: store.state.themeSettingsState.textColor,
      iconColor: store.state.themeSettingsState.iconColor,
      theme: store.state.localStorageState.theme,
      currentPage: store.state.triviaState.currentPage,
      startPage: store.state.triviaState.startPage,
      endPage: store.state.triviaState.endPage,
      language: store.state.localStorageState.language,
      currentAnswers: store.state.triviaState.listCurrentAnswers,
      questions: store.state.triviaState.listQuestions,
      answeredQuestions: store.state.triviaState.listAnsweredQuestions,
      navigateToHome: () => store
          .dispatch(updateScreenThunk(NavigateFromTriviaToHomeScreenAction())),
      navigateToResult: () => store.dispatch(
          updateScreenThunk(NavigateFromTriviaToResultScreenAction())),
      changeIsShowDialog: (value) {
        store.dispatch(UpdateTriviaDialogAction(value));
      },
      changePage: (index) {
        _changeStartAndEndPage(store, index);
        _checkHasAnswer(store);
        store.dispatch(UpdateCurrentPageAction(index));
      },
      changeAnswer: (value, questionId, answerId) {
        List<List<Answer>> newListCurrentAnswers =
            store.state.triviaState.listCurrentAnswers;
        if (value != null) {
          newListCurrentAnswers[questionId][answerId].isSelected = value;
        } else {
          for (var answer in newListCurrentAnswers[questionId]) {
            answer.isSelected = false;
          }
          newListCurrentAnswers[questionId][answerId].isSelected = true;
        }
        store.dispatch(UpdateListCurrentAnswersAction(newListCurrentAnswers));
      },
    );
  }

  static _checkHasAnswer(Store<AppState> store) {
    int currentPage = store.state.triviaState.currentPage;
    List<Answer> currentAnswers =
        store.state.triviaState.listCurrentAnswers[currentPage];
    if (currentAnswers.where((element) => element.isSelected).isNotEmpty) {
      _changeAnsweredQuestions(store, currentPage);
    }
  }

  static _changeAnsweredQuestions(Store<AppState> store, int currentPage) {
    List<bool> newListAnsweredQuestions =
        store.state.triviaState.listAnsweredQuestions;
    newListAnsweredQuestions[currentPage] = true;
    store.dispatch(UpdateListAnsweredQuestionsAction(newListAnsweredQuestions));
  }

  static _changeStartAndEndPage(Store<AppState> store, int newPage) {
    int startPage = store.state.triviaState.startPage;
    int endPage = store.state.triviaState.endPage;

    if (newPage == 0) {
      startPage = 0;
      endPage = 10;
    }

    if (newPage > endPage - 1) {
      startPage++;
      endPage++;
    } else if (newPage < startPage) {
      startPage--;
      endPage--;
    }

    store.dispatch(UpdateStartPageAction(startPage));
    store.dispatch(UpdateEndPageAction(endPage));
  }
}
