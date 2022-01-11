import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/models/answer.dart';
import 'package:weekly_bible_trivia/models/firebase/question.dart';
import 'package:weekly_bible_trivia/models/result.dart';
import 'package:weekly_bible_trivia/redux/actions/weekly_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/firebase_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/radial_percent.dart';
import 'package:weekly_bible_trivia/widgets/result.dart';

class ResultContainer extends StatefulWidget {
  const ResultContainer({Key? key}) : super(key: key);

  @override
  _ResultContainerState createState() {
    return _ResultContainerState();
  }
}

class _ResultContainerState extends State<ResultContainer>
    with TickerProviderStateMixin {
  late Result _result;
  late List<List<Answer>> _listCorrectAnswers;
  late AnimationController _resultController;
  late AnimationController _radialPercentController;
  late AnimationController _secondRadialPercentController;
  late AnimationController _correctAnswersController;
  late Animation<double> _scaleResultAnimations;
  late Animation<Offset> _moveAnswersAnimation;
  late Animation<Offset> _moveRadialPercentAnimation;
  late Animation<Size> _resizeRadialPercentAnimation;

  @override
  void initState() {
    super.initState();
    _resultController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _radialPercentController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _secondRadialPercentController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _correctAnswersController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _scaleResultAnimations =
        CurvedAnimation(parent: _resultController, curve: Curves.easeIn);

    _resizeRadialPercentAnimation =
        Tween<Size>(begin: const Size(150, 150), end: const Size(100, 100)).animate(
            CurvedAnimation(
                parent: _secondRadialPercentController, curve: Curves.ease));

    _moveRadialPercentAnimation = Tween<Offset>(
      begin: const Offset(0.4, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _secondRadialPercentController, curve: Curves.ease));

    _moveAnswersAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _correctAnswersController,
      curve: Curves.ease,
    ));

    _radialPercentController
        .forward(
        from: _radialPercentController.value == 1
            ? 0
            : _radialPercentController.value)
        .whenComplete(() => _secondRadialPercentController
        .forward()
        .whenComplete(() => _resultController.forward().whenComplete(
            () => _correctAnswersController.forward())));
  }

  @override
  void dispose() {
    _resultController.dispose();
    _radialPercentController.dispose();
    _secondRadialPercentController.dispose();
    _correctAnswersController.dispose();
    super.dispose();
  }

  List<List<Answer>> _initListCorrectAnswers(List<Question> listQuestions) {
    List<List<Answer>> listCorrectAnswers = List.generate(
        listQuestions.length,
        (questionIndex) => List.generate(
            listQuestions[questionIndex].answersEn.length,
            (answerIndex) => Answer(title: '', answerId: answerIndex)));

    for (int indexQuestion = 0;
        indexQuestion < listQuestions.length;
        indexQuestion++) {
      for (int indexAnswer = 0;
          indexAnswer < listQuestions[indexQuestion].correctAnswers.length;
          indexAnswer++) {
        int indexCorrectAnswer =
            listQuestions[indexQuestion].correctAnswers[indexAnswer];
        listCorrectAnswers[indexQuestion][indexCorrectAnswer].isSelected = true;
      }
    }
    return listCorrectAnswers;
  }

  Result _countResult(List<List<Answer>> listUserAnswers,
      List<List<Answer>> listCorrectAnswers) {
    int countQuestions = listCorrectAnswers.length;
    int countCorrectAnswers = 0;
    int countWrongAnswers = 0;
    int countSkippedAnswers = 0;
    List<String> listStateAnswers = List.filled(countQuestions, '');

    for (int i = 0; i < listUserAnswers.length; i++) {
      String stateAnswer =
          _checkAnswer(listUserAnswers[i], listCorrectAnswers[i]);

      if (stateAnswer == CORRECT) {
        countCorrectAnswers++;
      } else if (stateAnswer == WRONG) {
        countWrongAnswers++;
      } else {
        countSkippedAnswers++;
      }
      listStateAnswers[i] = stateAnswer;
    }

    return Result(countQuestions, countCorrectAnswers, countWrongAnswers,
        countSkippedAnswers, listStateAnswers);
  }

  String _checkAnswer(List<Answer> userAnswers, List<Answer> correctAnswers) {
    bool isAnswerCorrect = true;

    if (userAnswers.where((element) => element.isSelected).isEmpty) {
      return SKIPPED;
    }
    for (int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i].isSelected != correctAnswers[i].isSelected) {
        isAnswerCorrect = false;
      }
    }
    return isAnswerCorrect ? CORRECT : WRONG;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        onInit: (Store<AppState> store) {
          List<Question> listQuestions = store.state.triviaState.listQuestions;
          List<List<Answer>> listUserAnswers =
              store.state.triviaState.listCurrentAnswers;
          _listCorrectAnswers = _initListCorrectAnswers(listQuestions);
          _result = _countResult(listUserAnswers, _listCorrectAnswers);

          if(store.state.triviaState.isTimeTrivia){
            int percentOfCorrectAnswers = (_result.countCorrectAnswers / _result.countQuestions * 100).toInt();
            store.dispatch(createRecordToFirebaseThunk(percentOfCorrectAnswers));
            store.dispatch(UpdateWeeklyTriviaPassedAction(true));
          }
        },
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          bool isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;
          return SizedBox.expand(
            child: Container(
              color: Color(viewModel.primaryColor),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SlideTransition(
                          position: _moveRadialPercentAnimation,
                          child: AnimatedBuilder(
                              animation: _resizeRadialPercentAnimation,
                              builder: (context, child) {
                                return SizedBox(
                                  height: _resizeRadialPercentAnimation
                                      .value.height,
                                  width:
                                      _resizeRadialPercentAnimation.value.width,
                                  child: RadialPercentWidget(
                                    controller: _radialPercentController,
                                    percentCorrect: _result.countCorrectAnswers / _result.countQuestions,
                                    percentWrong: _result.countWrongAnswers / _result.countQuestions,
                                    textColor: Color(viewModel.textColor),
                                    fillColor: Color(viewModel.cardColor),
                                    skippedColor: Colors.grey.shade300,
                                    lineWidth: 8,
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        FadeTransition(
                          opacity: _scaleResultAnimations,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                correct.i18n +
                                    ": " +
                                    _result.countCorrectAnswers.toString(),
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.lightGreen),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                wrong.i18n +
                                    ": " +
                                    _result.countWrongAnswers.toString(),
                                style:
                                    const TextStyle(fontSize: 17, color: Colors.redAccent),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                skipped.i18n +
                                    ": " +
                                    _result.countSkippedAnswers.toString(),
                                style:
                                    const TextStyle(fontSize: 17, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: isPortrait ? 70 : 30,
                    ),
                    SlideTransition(
                      position: _moveAnswersAnimation,
                      child: ResultView(
                        viewModel.listQuestions,
                        viewModel.listUserAnswers,
                        _listCorrectAnswers,
                        _result.listStateAnswers,
                        viewModel.language,
                        titleColor: Color(viewModel.shadowColor),
                        textColor: Color(viewModel.textColor),
                        cardColor: Color(viewModel.cardColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class _ViewModel {
  final int primaryColor;
  final int cardColor;
  final int shadowColor;
  final int textColor;
  final String theme;
  List<List<Answer>> listUserAnswers;
  List<Question> listQuestions;
  String language;

  _ViewModel(
      {required this.primaryColor,
      required this.cardColor,
        required this.shadowColor,
      required this.textColor,
      required this.theme,
      required this.listUserAnswers,
      required this.listQuestions,
      required this.language});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      primaryColor: store.state.themeSettingsState.primaryColor,
      cardColor: store.state.themeSettingsState.cardColor,
      shadowColor: store.state.themeSettingsState.shadowColor,
      textColor: store.state.themeSettingsState.textColor,
      theme: store.state.localStorageState.theme,
      listUserAnswers: store.state.triviaState.listCurrentAnswers,
      listQuestions: store.state.triviaState.listQuestions,
      language: store.state.localStorageState.language,
    );
  }
}
