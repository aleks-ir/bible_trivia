import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/constants_map.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/firebase_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';
import 'package:weekly_bible_trivia/widgets/progress_indicators.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer>
    with TickerProviderStateMixin {
  late double _scale;
  late AnimationController _buttonAnimationController;
  late _ViewModel _viewModel;

  @override
  void initState() {
    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _buttonAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          _scale = 0.8 - _buttonAnimationController.value;
          bool isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;
          _viewModel = viewModel;

          return Container(
              margin: EdgeInsets.only(top: 70),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        selectBackgroundImage(viewModel.theme, isPortrait)),
                    fit: BoxFit.fill),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: isPortrait ? 30 : 60, top: isPortrait ? 40 : 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _getDateString(viewModel.currentDate,
                            mapMonths: selectMapMonths(viewModel.language)),
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: INTER,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: isPortrait
                            ? MediaQuery.of(context).size.height /
                                (viewModel.theme == DARK ? 8 : 3.5)
                            : 80),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            (viewModel.language == RUSSIAN
                                    ? mapBooksRu[viewModel.nextTriviaBook] ?? ''
                                    : viewModel.nextTriviaBook) +
                                "\t\t" +
                                viewModel.nextTriviaChapters,
                            style: TextStyle(
                                fontFamily: OPEN_SANS,
                                fontWeight: FontWeight.w600,
                                fontSize: 26,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: isPortrait ? 10 : 5,
                          ),
                          Text(
                            viewModel.nextTriviaBook.isEmpty
                                ? ''
                                : _getDateString(viewModel.nextTriviaDate),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: INTER,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: isPortrait ? 20 : 10,
                          ),
                          Visibility(
                            visible:
                            !viewModel.isPassed &&
                                _compareToDate(viewModel.currentDate,
                                    viewModel.nextTriviaDate),
                            child: GestureDetector(
                              onHorizontalDragStart: _drag,
                              onVerticalDragStart: _drag,
                              onTapDown: _tapDown,
                              onTapUp: _tapUp,
                              child: Transform.scale(
                                  scale: _scale,
                                  child: animatedHomeButton(
                                    child: viewModel.isLoadingData
                                        ? buttonCircularProgressIndicator(
                                            color: Color(viewModel.iconColor))
                                        : Text(
                                            go.i18n,
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    Color(viewModel.iconColor)),
                                          ),
                                    height: 140,
                                    width: 55,
                                    backgroundColor:
                                        Color(viewModel.primaryColor),
                                    shadowColor: Color(viewModel.shadowColor),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  String _getDateString(DateTime currentDate,
      {Map<int, String> mapMonths: const {}}) {
    if (mapMonths.isEmpty) {
      return currentDate.day.toString() +
          " - " +
          currentDate.month.toString() +
          " - " +
          currentDate.year.toString();
    } else {
      String month = mapMonths[currentDate.month] ?? "";
      return currentDate.day.toString() +
          " " +
          month +
          " " +
          currentDate.year.toString();
    }
  }

  bool _compareToDate(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  void _drag(DragStartDetails details) {
    _buttonAnimationController.reverse();
  }

  void _tapDown(TapDownDetails details) {
    _buttonAnimationController.fling();
  }

  void _tapUp(TapUpDetails details) {
    _buttonAnimationController.reverse();
    _viewModel.getDataAndNavigateToTrivia();
  }
}

class _ViewModel {
  final bool isLoadingData;
  final int primaryColor;
  final int shadowColor;
  final int iconColor;
  final int textColor;
  final String theme;
  final String language;
  final bool isPassed;
  final bool isAuthenticated;
  final String nextTriviaBook;
  final String nextTriviaChapters;
  final DateTime nextTriviaDate;
  final DateTime currentDate;

  final Function() getDataAndNavigateToTrivia;

  _ViewModel({
    required this.isLoadingData,
    required this.primaryColor,
    required this.shadowColor,
    required this.iconColor,
    required this.textColor,
    required this.theme,
    required this.language,
    required this.isPassed,
    required this.isAuthenticated,
    required this.nextTriviaBook,
    required this.nextTriviaChapters,
    required this.nextTriviaDate,
    required this.currentDate,
    required this.getDataAndNavigateToTrivia,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      isLoadingData: store.state.loadingState.isLoadingDataFromFirebase,
      primaryColor: store.state.themeSettingsState.primaryColor,
      shadowColor: store.state.themeSettingsState.shadowColor,
      iconColor: store.state.themeSettingsState.iconColor,
      textColor: store.state.themeSettingsState.textColor,
      theme: store.state.localStorageState.theme,
      language: store.state.localStorageState.language,
      isPassed: store.state.weeklyTriviaState.isPassed,
      isAuthenticated:
          store.state.authenticationState.status == AuthenticationStatus.loaded,
      currentDate: store.state.infoTriviaState.currentDate,
      nextTriviaBook: store.state.infoTriviaState.nextBookName,
      nextTriviaDate: store.state.infoTriviaState.nextDate,
      nextTriviaChapters: store.state.infoTriviaState.nextChapters,
      getDataAndNavigateToTrivia: () {
        store.dispatch(UpdateIsTimeTriviaAction(true));
        store.dispatch(getDataWeeklyTriviaFromFirebaseAndNavigateThunk());
      },
    );
  }
}
